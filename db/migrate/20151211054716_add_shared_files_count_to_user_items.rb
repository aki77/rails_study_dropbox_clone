class AddSharedFilesCountToUserItems < ActiveRecord::Migration
  def change
    add_column :user_items, :shared_files_count, :integer, null: false, default: 0
  end
end
