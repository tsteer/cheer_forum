class ForumPost < ApplicationRecord
  belongs_to :forum_thread
  validates_presence_of :message, :forum_thread
end
