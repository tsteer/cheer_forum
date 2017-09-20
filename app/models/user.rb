class User < ApplicationRecord
  validates_presence_of :username, :email, :date_of_birth
  validate :check_user_age, unless: Proc.new { |a| a.date_of_birth.blank? }
  validates_uniqueness_of :email, :username

  def check_user_age
    if self.date_of_birth > 14.years.ago
      errors.add(:base, "Date of birth is within last 14 years")
    end
  end
end
