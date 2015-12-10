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

class SharedFile < ActiveRecord::Base
  attr_accessor :email

  belongs_to :file, class_name: 'UserFile'
  belongs_to :shared_user, class_name: 'User'

  validates :user_item_id, presence: true
  validates :email, presence: true
  validate :email2shared_user
  validates :shared_user_id, presence: { message: '入力されたメールアドレスのユーザは存在しません。' }, uniqueness: { scope: :user_item_id }

  after_validation -> { errors[:email].concat(errors[:shared_user_id]) if errors.include?(:shared_user_id) }

  private

    def email2shared_user
      self.shared_user = User.find_by(email: email) if email.present?
    end
end
