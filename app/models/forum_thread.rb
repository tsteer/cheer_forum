class ForumThread < ApplicationRecord
  belongs_to :forum_category
  belongs_to :user
  has_many :forum_posts, dependent: :destroy
  validates_presence_of :title, :forum_category, :user

  def self.latest
    order(updated_at: :desc).limit(3)
  end
end
