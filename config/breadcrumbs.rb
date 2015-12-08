crumb :folder do |folder|
  link folder.name, folder
  unless folder.root?
    parent :folder, folder.parent
  end
end

crumb :item_action do |item|
  parent :folder, item.parent
end
