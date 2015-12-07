class AddFileToUserItems < ActiveRecord::Migration
  def change
    add_column :user_items, :file, :string
  end
end
