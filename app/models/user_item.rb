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
#

class UserItem < ActiveRecord::Base
  has_ancestry

  validates :name, presence: true
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
