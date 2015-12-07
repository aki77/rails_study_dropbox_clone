class UserFile < UserItem
  validates :file, presence: true

  mount_uploader :file, FileUploader
end
