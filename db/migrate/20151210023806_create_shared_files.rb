class CreateSharedFiles < ActiveRecord::Migration
  def change
    create_table :shared_files do |t|
      t.integer :user_item_id, null: false
      t.integer :shared_user_id, null: false

      t.timestamps null: false
      t.index %i(user_item_id shared_user_id), unique: true
    end
  end
end
