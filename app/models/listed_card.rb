class ListedCard < ActiveRecord::Base
	belongs_to :card
	belongs_to :list
	# belongs_to :initiator_list, class_name: "List"
	# belongs_to :receiver_list, class_name: "List" 
	# should a ListedCard belong to a list?????

	def add_one
		self.amount += 1
		self.save!
	end

	def remove_one
		if self.amount > 1
			self.amount -= 1
			self.save
		else
			self.destroy
		end
	end

	def change_owner(qty, user)
		self.amount -= qty

		# If amount in listed_card will be at least 1 after trade
		if self.amount >= 1 
			# If receiving user already has the card in their inventory
			if user.listed_cards.where(card_id: self.card_id, status: 2)[0]
				lc = user.listed_cards.where(card_id: self.card_id, status: 2)[0]
				lc.amount += qty
			#
			elsif self.amount < 1
			new_listed_card = ListedCard.create
			new_listed_card.user = user
			new_listed_card.card = self.card
			new_listed_card.status = 2
			new_listed_card
			end
		# Otherwise, if entire amount of listed_card is being traded
		else

		end
	end

end










