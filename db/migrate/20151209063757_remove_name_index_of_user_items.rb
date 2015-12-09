class RemoveNameIndexOfUserItems < ActiveRecord::Migration
  def change
    remove_index :user_items, %i(user_id ancestry name)
  end
end
