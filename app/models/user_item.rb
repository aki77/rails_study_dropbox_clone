class UserItem < ActiveRecord::Base
  ROOT_FOLDER_ID = 0

  has_ancestry

  validates :name, presence: true,
                   uniqueness: { scope: %i(user_id ancestry type) }
  validates :user_id, presence: true

  belongs_to :user
end
