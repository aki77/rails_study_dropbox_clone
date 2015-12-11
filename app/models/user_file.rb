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

class UserFile < UserItem
  validates :file, presence: true

  mount_uploader :file, FileUploader

  before_validation :update_file_attributes, on: :create

  has_many :shared_files, foreign_key: 'user_item_id', dependent: :destroy

  accepts_nested_attributes_for :shared_files

  def copy!
    new_file = parent.build_file(name: "#{name} のコピー")
    new_file.file = file.file
    new_file.save!
  end

  private

    def update_file_attributes
      self.content_type = file.file.content_type
    end
end
