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

# puts "Loading JSON..."
# magic = ActiveSupport::JSON.decode File.read('vendor/assets/jsondata/AllSets.json')



# magic.each do |set_array|
# 	set_data = set_array[1]
# 	set_columns = []
# 	set_array[1].each_key {|k| set_columns << k }
# 	card_columns = []
# 	set_array[1]['cards'][0].each_key {|k| card_columns << k }

# 	puts "Creating #{set_array[1]['name']}"

# 	cset = CardSet.create(name: 			set_array[1]['name'], 
# 						code: 			set_array[1]['code'], 
# 						gatherer_code: 	set_array[1]['gathererCode'], 
# 						release_date: 	set_array[1]['releaseDate'], 
# 						border: 		set_array[1]['border'], 
# 						set_type: 		set_array[1]['type']
# 				  )
# 	if card_columns.include? 'block'
# 		cset.block   = set_array[1]['block']
# 	end
# 	if card_columns.include? 'booster'
# 		cset.block   = set_array[1]['booster']
# 	end
# 	cset.save

# 	puts "Adding Cards... #{set_array[1]['cards'].size}"
# 	set_array[1]['cards'].each do |card|
# 		begin
# 			c = Card.create(layout: 	card['layout'],
# 						multiverseid: 	card['multiverseid'],
# 						name: 			card['name'],
# 						cmc: 			card['cmc'],
# 						rarity: 		card['rarity'],
# 						artist: 		card['artist'],
# 						power: 			card['power'],
# 						toughness: 		card['toughness'],
# 						mana_cost: 		card['manaCost'],
# 						text: 			card['text'],
# 						flavor: 		card['flavor'],
# 						image_name: 	card['imageName']
# 						)

# 			c.card_set = cset
# 			c.save
			
# 			if card['types']
# 				card['types'].each do |type| 
# 					ct = CardType.find_or_create_by(name: type)
# 					c.card_types << ct
# 					c.save
# 				end
# 			end

# 			if card['colors']
# 				card['colors'].each do |color| 
# 					ccolor = Color.find_or_create_by(name: color)
# 					c.colors << ccolor
# 					c.save
# 				end
# 			end

# 			if card['subtypes']
# 				card['subtypes'].each do |subtype| 
# 					stype = Subtype.find_or_create_by(name: subtype)
# 					c.subtypes << stype
# 					c.save
# 				end
# 			end
			
# 		rescue => e
# 			puts e
# 			binding.pry
# 		end
# 	end

# end
User.create(
	first_name: 'Eric',
	last_name: 'Boshart',
	dci_number: 53425,
	email: 'eb@email.org',
	longitude: 43.663292,
	latitude: -79.457002,
	password: "imcool"
)
User.create(
	first_name: 'Ralphie',
	last_name: 'Gorgeous ',
	dci_number: 234,
	email: 'RG@cool.com',
	longitude: 43.686708, 
	latitude: -79.401639,
	password:'password'

)
User.create(
	first_name: 'Laura',
	last_name: 'Foxtrot ',
	dci_number: 411.9,
	email: 'lf@fox.org',
	longitude: 43.697755,
	latitude: -79.328962,
	password:'cool'
	 

)
User.create(
	first_name: 'Matt',
	last_name: 'Gregory ',
	dci_number: 565,
	email: 'MG@mgmagic.org',
	longitude: 43.904908, 
	latitude: -79.652715,
	password:'password'

)
User.create(
	first_name: 'Steph',
	last_name: 'Stevens ',
	dci_number: 45656,
	email: 'SS@trouble.com',
	longitude: 43.682455, 
	latitude: -79.392130,
	password:'password'

)
User.create(
	first_name: 'Sissy',
	last_name: 'Kong',
	dci_number: 232,
	email: 'misssiss@cist.org',
	longitude: 43.278512, 
	latitude: -80.439667,
	password:'pass'

)
# User.create(
# 	first_name: '',
# 	last_name: ' ',
# 	dci_number: ,
# 	email: '',
# 	longitude: ,
# 	latitude: ,
# 	password:''

# )
