# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# puts "Destroying CardSets..."
# CardSet.destroy_all
# puts "Destroying Cards..."
# Card.destroy_all

puts "Loading JSON..."
magic = ActiveSupport::JSON.decode File.read('vendor/assets/jsondata/AllSets.json')



magic.each do |set_array|
	set_data = set_array[1]
	set_columns = []
	set_array[1].each_key {|k| set_columns << k }
	card_columns = []
	set_array[1]['cards'][0].each_key {|k| card_columns << k }

	# binding.pry

	puts "Creating #{set_array[1]['name']}"

	# if ((card_columns.include? 'booster') && (card_columns.include? 'block'))
	# 	CardSet.create(name: 			set_array[1]['name'], 
	# 					code: 			set_array[1]['code'], 
	# 					gatherer_code: 	set_array[1]['gathererCode'], 
	# 					release_date: 	set_array[1]['releaseDate'], 
	# 					border: 		set_array[1]['border'], 
	# 					set_type: 		set_array[1]['type'],
	# 					block: 			set_array[1]['block'], 
	# 					booster: 		set_array[1]['booster'].to_s
	# 				  )
	# elsif card_columns.include? 'booster'
	# 	CardSet.create(name: 			set_array[1]['name'], 
	# 					code: 			set_array[1]['code'], 
	# 					gatherer_code: 	set_array[1]['gathererCode'], 
	# 					release_date: 	set_array[1]['releaseDate'], 
	# 					border: 		set_array[1]['border'], 
	# 					set_type: 		set_array[1]['type'],
	# 					booster: 		set_array[1]['booster'].to_s
	# 				  )
	# else 
	# 	CardSet.create(name: 			set_array[1]['name'], 
	# 					code: 			set_array[1]['code'], 
	# 					gatherer_code: 	set_array[1]['gathererCode'], 
	# 					release_date: 	set_array[1]['releaseDate'], 
	# 					border: 		set_array[1]['border'], 
	# 					set_type: 		set_array[1]['type']
	# 				  )
	# end

	c = CardSet.create(name: 			set_array[1]['name'], 
						code: 			set_array[1]['code'], 
						gatherer_code: 	set_array[1]['gathererCode'], 
						release_date: 	set_array[1]['releaseDate'], 
						border: 		set_array[1]['border'], 
						set_type: 		set_array[1]['type']
				  )
	if card_columns.include? 'block'
		c.block   = set_array[1]['block']
	end
	if card_columns.include? 'booster'
		c.block   = set_array[1]['booster']
	end
	c.save




	
	puts "Adding Cards... #{set_array[1]['cards'].size}"
	set_array[1]['cards'].each do |card|
		# begin
			c = Card.create(layout: 	card['layout'], 
						card_type: 		card['type'],
						card_types: 	card['types'],
						colors: 		card['colors'],
						multiverseid: 	card['multiverseid'],
						name: 			card['name'],
						sub_types: 		card['subtypes'],
						cmc: 			card['cmc'],
						rarity: 		card['rarity'],
						artist: 		card['artist'],
						power: 			card['power'],
						toughness: 		card['toughness'],
						mana_cost: 		card['manaCost'],
						text: 			card['text'],
						flavor: 		card['flavor'],
						image_name: 	card['imageName']
						)
			card['types'].each do |type| 
				ct = CardType.find_or_create_by(name: type)
				c.card_types << ct
				c.save
			end

			card['colors'].each do |color| 
				ccolor = Color.find_or_create_by(name: color)
				c.colors << ccolor
				c.save
			end

		# rescue => e
		# 	binding.pry
		# end
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



