class AddUserFkToForumThreads < ActiveRecord::Migration[5.1]
  def change
    add_reference :forum_threads, :user, foreign_key: true
  end
end
