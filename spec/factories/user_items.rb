# == Schema Information
#
# Table name: user_items
#
#  id                 :integer          not null, primary key
#  name               :string           not null
#  user_id            :integer          not null
#  type               :string           not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  file               :string
#  ancestry           :string
#  content_type       :string           default(""), not null
#  shared_files_count :integer          default(0), not null
#
# Indexes
#
#  index_user_items_on_ancestry  (ancestry)
#

FactoryGirl.define do
  factory :user_item do
    name "MyString"
user_id 1
parent_folder_id 1
type ""
  end

end
