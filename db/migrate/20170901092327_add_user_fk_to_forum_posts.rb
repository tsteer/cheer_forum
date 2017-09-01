class AddUserFkToForumPosts < ActiveRecord::Migration[5.1]
  def change
    add_reference :forum_posts, :user, foreign_key: true
  end
end
