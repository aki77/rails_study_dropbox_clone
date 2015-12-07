class ChangeDefaultParentFolderIdOfUserItems < ActiveRecord::Migration
  def up
    change_column :user_items, :parent_folder_id, :integer, null: false, default: 0
  end

  def down
    change_column :user_items, :parent_folder_id, :integer, null: false, default: nill
  end
end
