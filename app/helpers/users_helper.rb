module UsersHelper

	def all_mana_cost_images(card)
		if card.mana_cost

			tags = ""
			
			card.mana_cost.scan(/\w/).each do |mc|
				tags += image_tag mana_cost_url(mc)
			end
			tags.html_safe
		
		end
	end

	def mana_cost_url(type)
		"http://mtgimage.com/symbol/mana/#{type}/16.gif"
	end

end
