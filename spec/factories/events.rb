# == Schema Information
#
# Table name: events
#
#  id         :integer          not null, primary key
#  key        :integer          not null
#  name       :string           not null
#  user_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_events_on_user_id  (user_id)
#

FactoryGirl.define do
  factory :event do
    message "MyString"
  end

end
