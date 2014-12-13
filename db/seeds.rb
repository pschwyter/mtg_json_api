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
magic = ActiveSupport::JSON.decode File.read('vendor/assets/jsondata/AllSets.json')

binding.pry

magic.each do |set_array|
	set_data = set_array[1]
	set_columns = []
	set_array[1].each_key {|k| set_columns << k }
	card_columns = []
	set_array[1]['cards'][0].each_key {|k| card_columns << k }
	puts "Creating #{set_array[1]['name']}"

	if card_columns.length == 7
		CardSet.create(name: set_array[1][set_columns[0]], 
						code: set_array[1][set_columns[1]], 
						gatherer_code: set_array[1][set_columns[2]], 
						release_date: set_array[1][set_columns[3]], 
						border: set_array[1][set_columns[4]], 
						set_type: set_array[1][set_columns[5]], 
						booster: set_array[1][set_columns[6]].to_s
					  )
	elsif card_columns.length == 6
		CardSet.create(name: set_array[1][set_columns[0]], 
						code: set_array[1][set_columns[1]], 
						gatherer_code: set_array[1][set_columns[2]], 
						release_date: set_array[1][set_columns[3]], 
						border: set_array[1][set_columns[4]], 
						set_type: set_array[1][set_columns[5]]
					  )
	end
	puts "Adding Cards... #{set_array[1]['cards'].size}"
	set_array[1]['cards'].each do |card|

		Card.create(layout: card[card_columns[0]], 
					card_type: card[card_columns[1]],
					card_types: card[card_columns[2]].to_s,
					colors: card[card_columns[3]].to_s,
					multiverseid: card[card_columns[4]],
					name: card[card_columns[5]],
					sub_types: card[card_columns[6]].to_s,
					cmc: card[card_columns[7]],
					rarity: card[card_columns[8]],
					artist: card[card_columns[9]],
					power: card[card_columns[10]],
					toughness: card[card_columns[11]],
					mana_cost: card[card_columns[12]],
					text: card[card_columns[13]],
					flavor: card[card_columns[14]],
					image_name: card[card_columns[15]]
					)
	end


	# column_name = key
	# column_name = 'gatherer_code' if key == 'gathererCode'
	# column_name = 'set_type' if key == 'type'
	# set = CardSet.create( value.reject {|k,v| k =='cards'})
	# binding.pry
	# cards = value['cards']
	
	# card_records = cards.map { |card| Card.create(card) }


end


# magic.each do |key, value|
# 	puts "* Importing #{value["name"]}..."
# 	set = CardSet.create value.reject {|k, v| k == 'cards'}
# 	cards = value['cards']
# 	puts "  |_ cards: #{cards.size}"
# 	card_records = cards.map { |card| Card.create(card) }
# 	set.cards = card_records

# 	puts
# end


# binding.pry

# cards.each do |card|
# 	p card
# 	Card.create(card)
# end




	# CardSet.create(name: set_array[1][set_columns[0]], 
	# 				code: set_array[1][set_columns[1]], 
	# 				gatherer_code: set_array[1][set_columns[2]], 
	# 				release_date: set_array[1][set_columns[3]], 
	# 				border: set_array[1][set_columns[4]], 
	# 				set_type: set_array[1][set_columns[5]], 
	# 				booster: set_array[1][set_columns[6]].to_s
	# 			  )



