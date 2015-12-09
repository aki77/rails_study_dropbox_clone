class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.integer :key, null: false, limit: 1
      t.string :name, null: false
      t.integer :user_id, null: false
      t.timestamps null: false

      t.index :user_id
    end
  end
end
