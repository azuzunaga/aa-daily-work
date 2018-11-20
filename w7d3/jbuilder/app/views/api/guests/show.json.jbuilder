json.partial! 'api/guests/guest', guest: @guest

json.set! :gifts do
  json.array! @guest.gifts, :title, :description
end
