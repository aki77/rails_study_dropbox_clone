class AddAncestryToUserItems < ActiveRecord::Migration
  def change
    add_column :user_items, :ancestry, :string
    add_index :user_items, :ancestry
  end
end
