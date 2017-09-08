class ForumCategory < ApplicationRecord
  has_many :forum_threads
  validates_presence_of :title
end
