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

  before_validation :update_file_attributes, on: :create, unless: :content_type?, if: :file?

  has_many :shared_files, foreign_key: 'user_item_id', dependent: :destroy

  accepts_nested_attributes_for :shared_files

  def copy!
    parent.children.create!(
      name: "#{name} のコピー",
      type: 'UserFile',
      file: file.file,
      content_type: content_type,
    )
  end

  def image?
    media_type == 'image'
  end

  def text?
    media_type == 'text'
  end

  def media_type
    content_type.split('/').first
  end

  def content
    File.read(file.path).toutf8
  end

  private

    def update_file_attributes
      self.content_type = file.file.content_type
    end
end
