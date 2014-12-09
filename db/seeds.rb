# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

magic = ActiveSupport::JSON.decode File.read('vendor/assets/jsondata/Allsets.json')

magic.each do |key, value|
	CardSet.create value
end

# binding.pry

# cards.each do |card|
# 	p card
# 	Card.create(card)
# end


