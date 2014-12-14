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

	puts "Creating #{set_array[1]['name']}"

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
		begin
			c = Card.create(layout: 	card['layout'],
						multiverseid: 	card['multiverseid'],
						name: 			card['name'],
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
			if card['types']
				card['types'].each do |type| 
					ct = CardType.find_or_create_by(name: type)
					c.card_types << ct
					c.save
				end
			end

			if card['colors']
				card['colors'].each do |color| 
					ccolor = Color.find_or_create_by(name: color)
					c.colors << ccolor
					c.save
				end
			end

			if card['subtypes']
				card['subtypes'].each do |subtype| 
					stype = Subtype.find_or_create_by(name: subtype)
					c.subtypes << stype
					c.save
				end
			end
			
		rescue => e
			puts e
			binding.pry
		end
	end

end

