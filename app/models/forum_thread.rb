class ForumThread < ApplicationRecord
  belongs_to :forum_category
  belongs_to :user
  validates_presence_of :title, :forum_category, :user
end
