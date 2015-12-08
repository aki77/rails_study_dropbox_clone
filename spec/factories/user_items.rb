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

FactoryGirl.define do
  factory :user_item do
    name "MyString"
user_id 1
parent_folder_id 1
type ""
  end

end
