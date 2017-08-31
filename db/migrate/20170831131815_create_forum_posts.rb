class CreateForumPosts < ActiveRecord::Migration[5.1]
  def change
    create_table :forum_posts do |t|
      t.string :message
      t.integer :forum_thread_id

      t.timestamps
    end
    add_foreign_key :forum_posts, :forum_threads
  end
end
