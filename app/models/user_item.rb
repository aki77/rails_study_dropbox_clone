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

class UserItem < ActiveRecord::Base
  has_ancestry

  validates :name, presence: true
  validates :user_id, presence: true
  validates :content_type, presence: true

  belongs_to :user

  scope :files, -> { where(type: 'UserFile') }
  scope :folders, -> { where(type: 'UserFolder') }

  after_create -> { create_event(:add) }
  after_destroy -> { create_event(:remove) }
  after_update -> { create_event(:move) }, if: :ancestry_changed?
  after_update -> { create_event(:rename, name_was) }, if: :name_changed?

  default_value_for :user do |i|
    i.parent.user unless i.root?
  end

  def folder?
    type == 'UserFolder'
  end

  def file?
    type == 'UserFile'
  end

  def full_name
    '/' + ancestors.map(&:name).push(name).join('/')
  end

  private

    def create_event(key, name = nil)
      name ||= self.name
      user.events.create!(key: key, name: name)
    end
end
