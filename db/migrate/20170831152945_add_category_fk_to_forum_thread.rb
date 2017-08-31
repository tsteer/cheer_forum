class AddCategoryFkToForumThread < ActiveRecord::Migration[5.1]
  def change
    add_reference :forum_threads, :forum_category, foreign_key: true
  end
end
