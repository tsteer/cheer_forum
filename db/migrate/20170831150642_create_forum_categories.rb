class CreateForumCategories < ActiveRecord::Migration[5.1]
  def change
    create_table :forum_categories do |t|
      t.string :title

      t.timestamps
    end
  end
end
