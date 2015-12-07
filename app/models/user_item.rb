class UserItem < ActiveRecord::Base
  ROOT_FOLDER_ID = 0

  validates :name, presence: true,
                   uniqueness: { scope: %i(user_id parent_folder_id type) }
  validates :user_id, presence: true

  belongs_to :user

  scope :root, -> { where(parent_folder_id: ROOT_FOLDER_ID) }
  scope :children, ->(_folder) { where(parent_folder: _folder) }

  belongs_to :parent_folder, class_name: 'UserFolder', foreign_key: 'parent_folder_id'

  def has_parent?
    parent_folder_id != ROOT_FOLDER_ID
  end
end
