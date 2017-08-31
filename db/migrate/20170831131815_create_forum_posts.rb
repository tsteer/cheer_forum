class CreateForumPosts < ActiveRecord::Migration[5.1]
  def change
    create_table :forum_posts do |t|
      t.string :message, null: false
      t.references :forum_thread, foreign_key: true

      t.timestamps
    end
  end
end
