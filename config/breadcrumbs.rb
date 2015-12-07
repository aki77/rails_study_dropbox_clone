crumb :root do
  link 'Home', root_user_folders_path
end

crumb :folder do |folder|
  link folder.name, folder
  if folder.has_parent?
    parent :folder, folder.parent_folder
  else
    parent :root
  end
end
