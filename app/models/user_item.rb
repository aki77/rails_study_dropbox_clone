class UserItem < ActiveRecord::Base
  validates :name, presence: true,
                   uniqueness: { scope: %i(user_id parent_folder_id type) }
  validates :user_id, presence: true

  belongs_to :user

  scope :root, -> { where(parent_folder_id: 0) }
end
