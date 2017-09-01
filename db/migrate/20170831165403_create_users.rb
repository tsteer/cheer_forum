class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :username
      t.string :email
      t.date :date_of_birth

      t.timestamps
    end
  end
end
