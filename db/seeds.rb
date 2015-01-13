# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.delete_all 
User.create(
	first_name: 'Eric',
	last_name: 'Boshart',
	dci_number: 53425,
	email: 'eb@email.org',
	latitude: 43.663292,
	longitude: -79.457002,
	password: "imcool"
)

User.create(
	first_name: 'Ralphie',
	last_name: 'Gorgeous ',
	dci_number: 234,
	email: 'RG@cool.com',
	latitude: 43.686708, 
	longitude: -79.401639,
	password:'password'

)

User.create(
	first_name: 'Laura',
	last_name: 'Foxtrot ',
	dci_number: 411.9,
	email: 'lf@fox.org',
	latitude: 43.697755,
	longitude: -79.328962,
	password:'cool'
	 

)

User.create(
	first_name: 'Matt',
	last_name: 'Gregory ',
	dci_number: 565,
	email: 'MG@mgmagic.org',
	latitude: 43.904908, 
	longitude: -79.652715,
	password:'password'

)


User.delete_all 
User.create(
	first_name: 'Eric',
	last_name: 'Boshart',
	dci_number: 53425,
	email: 'eb@email.org',
	# latitude: 43.663292,
	# longitude: -79.457002,
	password: "imcool"
)

User.create(
	first_name: 'Ralphie',
	last_name: 'Gorgeous ',
	dci_number: 234,
	email: 'RG@cool.com',
	# latitude: 43.686708, 
	# longitude: -79.401639,
	password:'passreareareaword'

)

User.create(
	first_name: 'Laura',
	last_name: 'Foxtrot ',
	dci_number: 411.9,
	email: 'lf@fox.org',
	# latitude: 43.697755,
	# longitude: -79.328962,
	password:'cool'
	 

)

User.create(
	first_name: 'Matt',
	last_name: 'Gregory ',
	dci_number: 565,
	email: 'MG@mgmagic.org',
	# latitude: 43.904908, 
	# longitude: -79.652715,
	password:'password'

)


User.create(
	first_name: 'Steph',
	last_name: 'Stevens ',
	dci_number: 45656,
	email: 'SS@trouble.com',
	latitude: 43.682455, 
	longitude: -79.392130,
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

##########################
# GENERATING CARD DATABASE
##########################

# puts "Destroying Colors..."
# Color.destroy_all
# puts "Destroying Card Types..."
# CardType.destroy_all
# puts "Destroying Subtypes..."
# Subtype.destroy_all

# puts "Loading JSON..."
# magic = ActiveSupport::JSON.decode File.read('vendor/assets/jsondata/AllSets.json')

# class NilClass
# 	def flatten
# 		nil
# 	end
# end

# imported = 0
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
# 						set_type: 		set_array[1]['type'],
# 						block: 			set_array[1]['block'],
# 						booster:        set_array[1]['booster'].flatten
# 				  )

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
# 						image_name: 	card['imageName'],
# 						card_set:       cset
# 						)
			
# 			if card['types']
# 				card['types'].each do |type|
# 					CardType.find_or_create_by(name: type) 
# 					c.card_types << CardType.find_by(name: type)
# 				end
# 			end

# 			if card['colors']
# 				card['colors'].each do |color| 
# 					Color.find_or_create_by(name: color)
# 					c.colors << Color.find_by(name: color)
# 				end
# 			end

# 			if card['subtypes']
# 				card['subtypes'].each do |subtype| 
# 					Subtype.find_or_create_by(name: subtype)
# 					c.subtypes << Subtype.find_by(name: subtype)
# 				end
# 			end
# 			# binding.pry
# 		rescue => e
# 			puts e
# 			binding.pry
# 		end
# 	end

# end

####################################
# GENERATING CARD DATA FOR TYPEAHEAD 
####################################

# puts "Loading JSON..."
# magic = ActiveSupport::JSON.decode File.read('vendor/assets/jsondata/AllSets.json')
# cards_array = []

# # cards = ActiveSupport::JSON.decode File.read('vendor/assets/jsondata/card_array.json')
# # binding.pry
# magic.each do |set|
# 	set.last["cards"].each do |card| 
# 		card["card_set"] = set.last["name"]
# 		cards_array << card
# 	end
# end
# IO.write("vendor/assets/card_array.json", JSON.generate(cards_array))

