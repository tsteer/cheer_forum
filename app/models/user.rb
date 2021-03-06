require 'bcrypt'

class User < ApplicationRecord
  attr_accessor :remember_token, :activation_token, :reset_token
  validates_presence_of :username, :email, :date_of_birth
  validate :check_user_age, unless: Proc.new { |a| a.date_of_birth.blank? }
  validates_uniqueness_of :email, :username
  validates :password, length: { minimum: 6 }, if: :password_digest_changed?

  has_secure_password

  def check_user_age
    if self.date_of_birth > 18.years.ago
      errors.add(:base, "Users must be 18 or older")
    end
  end

  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def User.new_token
    SecureRandom.urlsafe_base64
  end

  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  def forget
    update_attribute(:remember_digest, nil)
  end

  def create_reset_digest
    self.reset_token = User.new_token
    update_columns(reset_digest:  User.digest(reset_token), reset_sent_at: Time.zone.now)
  end

  def send_password_reset_email
    UserMailer.password_reset(self).deliver_now
  end

  def password_reset_expired?
    reset_sent_at < 2.hours.ago
  end
end
