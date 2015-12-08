crumb :folder do |folder|
  link folder.name, folder
  unless folder.root?
    parent :folder, folder.parent
  end
end

crumb :folder_action do |folder|
  unless folder.root?
    parent :folder, folder.parent
  end
end
