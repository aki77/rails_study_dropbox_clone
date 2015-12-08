class RemoveParentFolderIdToUserItems < ActiveRecord::Migration
  def change
    remove_column :user_items, :parent_folder_id, :integer
  end
end
