# == Schema Information
#
# Table name: shared_files
#
#  id             :integer          not null, primary key
#  user_item_id   :integer          not null
#  shared_user_id :integer          not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
# Indexes
#
#  index_shared_files_on_user_item_id_and_shared_user_id  (user_item_id,shared_user_id) UNIQUE
#

FactoryGirl.define do
  factory :shared_file do
    user_id 1
    user_item_id 1
    shared_user_id 1
  end
end
