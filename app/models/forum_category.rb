class ForumCategory < ApplicationRecord
  has_many :forum_threads, dependent: :destroy
  validates_presence_of :title
end
