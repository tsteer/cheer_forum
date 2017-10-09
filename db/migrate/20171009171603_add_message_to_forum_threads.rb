class AddMessageToForumThreads < ActiveRecord::Migration[5.1]
  def change
    add_column :forum_threads, :message, :string
  end
end
