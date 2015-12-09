class AddContentTypeToUserItems < ActiveRecord::Migration
  def change
    add_column :user_items, :content_type, :string, null: false, default: ''
  end
end
