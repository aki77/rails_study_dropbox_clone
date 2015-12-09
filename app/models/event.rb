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

class Event < ActiveRecord::Base
  validates :key, presence: true
  validates :name, presence: true
  validates :user_id, presence: true

  belongs_to :user

  enum key: { add: 0, remove: 1, move: 2, rename: 3 }

  default_scope -> { order('id DESC') }
end
