module UserFoldersHelper
  def item_icon(item)
    icon_name = item.folder? ? 'folder-close' : 'file'
    content_tag(:span, '', class: "glyphicon glyphicon-#{icon_name}", 'aria-hidden' => true)
  end

  def folder_form_args(folder)
    folder.new_record? ? [folder.parent, folder] : [folder]
  end
end
