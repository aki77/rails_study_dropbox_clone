# == Schema Information
#
# Table name: user_items
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  user_id    :integer          not null
#  type       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  file       :string
#  ancestry   :string
#
# Indexes
#
#  index_user_items_on_ancestry  (ancestry)
#  item_name                     (user_id,name,type) UNIQUE
#

class UserItem < ActiveRecord::Base
  ROOT_FOLDER_ID = 0

  has_ancestry

  validates :name, presence: true,
                   uniqueness: { scope: %i(user_id ancestry type) }
  validates :user_id, presence: true

  belongs_to :user
end
