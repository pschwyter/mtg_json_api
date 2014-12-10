# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
puts "Destroying CardSets..."
CardSet.destroy_all
puts "Destroying Cards..."
Card.destroy_all

puts "Loading JSON..."
magic = ActiveSupport::JSON.decode File.read('vendor/assets/jsondata/Allsets.json')

magic.each do |key, value|
	puts "* Importing #{value["name"]}..."
	set = CardSet.create value.reject {|k, v| k == 'cards'}
	cards = value['cards']
	puts "  |_ cards: #{cards.size}"
	card_records = cards.map { |card| Card.create(card) }
	set.cards = card_records

	puts
end


# binding.pry

# cards.each do |card|
# 	p card
# 	Card.create(card)
# end


