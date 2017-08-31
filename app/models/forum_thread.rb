class ForumThread < ApplicationRecord
  belongs_to :forum_category
  validates_presence_of :title, :forum_category
end
