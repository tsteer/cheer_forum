class ChangeColumnName < ActiveRecord::Migration[5.1]
  def change
    rename_column :articles, :article, :article_text
  end
end
