ageGuest = Guest.where(age: 40..50)


json.array! ageGuest do |guest|
  json.extract! guest, :name, :age, :favorite_color
end
