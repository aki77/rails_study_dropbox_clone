class CreateUserItems < ActiveRecord::Migration
  def change
    create_table :user_items do |t|
      t.string :name, null: false
      t.integer :user_id, null: false
      t.integer :parent_folder_id, null: false
      t.string :type, null: false

      t.timestamps null: false

      t.index %i(user_id parent_folder_id name type), unique: true, name: 'item_name'
    end
  end
end
