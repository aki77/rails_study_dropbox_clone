module UserFoldersHelper
  def folder_breadcrumb(folder)
    if folder.present?
      breadcrumb :folder, @folder
    else
      breadcrumb :root
    end
  end
end
