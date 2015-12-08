crumb :folder do |folder|
  link folder.name, folder
  unless folder.root?
    parent :folder, folder.parent
  end
end

crumb :new_folder do |folder|
  unless folder.root?
    parent :folder, folder.parent
  end
end
