crumb :root do
  link 'Home', root_user_folders_path
end

crumb :folder do |folder|
  link folder.name, folder
  if folder.root?
    parent :root
  else
    parent :folder, folder.parent
  end
end

crumb :new_folder do |folder|
  if folder.root?
    parent :root
  else
    parent :folder, folder.parent
  end
end
