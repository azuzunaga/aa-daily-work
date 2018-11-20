json.pokemon do
  json.extract! @pokemon, :id, :name, :attack, :defense, :moves, :poke_type, :item_ids
  json.image_url asset_path(@pokemon.image_url)
end

# poke_items_ids = @pokemon.item_ids
#
# json.items do
#   poke_items_ids.each do |id|
#     json.set! id do
#       json.extract! @pokemon.items.find(id), :id, :name, :pokemon_id, :price, :happiness, :image_url
#     # end
#   end
# end
json.items do
  @pokemon.items.each do |item|
    json.set! item.id do
      json.extract! item, :id, :name, :pokemon_id, :price, :happiness
      json.image_url asset_path(item.image_url)
    end
  end
end
