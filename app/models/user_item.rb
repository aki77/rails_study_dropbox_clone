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
#  index_user_items_on_ancestry                       (ancestry)
#  index_user_items_on_user_id_and_ancestry_and_name  (user_id,ancestry,name)
#

class UserItem < ActiveRecord::Base
  has_ancestry

  validates :name, presence: true,
                   uniqueness: { scope: %i(user_id ancestry) }
  validates :user_id, presence: true

  belongs_to :user

  scope :files, -> { where(type: 'UserFile') }
  scope :folders, -> { where(type: 'UserFolder') }

  def folder?
    type == 'UserFolder'
  end

  def file?
    type == 'UserFile'
  end
end
