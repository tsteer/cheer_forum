class ForumPost < ApplicationRecord
  belongs_to :forum_thread
  belongs_to :user
  validates_presence_of :message, :forum_thread, :user
end
