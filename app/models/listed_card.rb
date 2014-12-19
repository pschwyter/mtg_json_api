class ListedCard < ActiveRecord::Base
	belongs_to :card
	belongs_to :list
	# belongs_to :initiator_list, class_name: "List"
	# belongs_to :receiver_list, class_name: "List" 
	# should a ListedCard belong to a list?????

	def add(n)
		self.amount += n
		self.save!
	end

	def remove(n)
		if self.amount > n
			self.amount -= n
			self.save
		else
			self.destroy
		end
	end

	def trade_to(user, qty)
		# self.amount -= qty
		# self.save
		binding.pry
		# If amount in listed_card will be at least 1 after trade
		if self.amount >= 1 
			# If receiving user already has the card in their tradeable_list
			if user.tradeable_list.listed_cards.find_by(card_id: self.card.id)
				lc = user.tradeable_list.listed_cards.find_by(card_id: self.card.id)
				lc.amount += qty
				lc.save
				binding.pry
			# If receiving user does NOT have th ecard in their tradeable_list
			elsif user.tradeable_list.listed_cards.find_by(card_id: self.card.id) == nil
				new_listed_card = ListedCard.create
				new_listed_card.card = self.card
				new_listed_card.amount = qty
				new_listed_card.tradeable_list = user.tradeable_list
				user.save
				new_listed_card.save
				binding.pry
			else
				raise "how did you mess up this bad?"
			end

		elsif self.amount < 1
			if user.tradeable_list.listed_cards.find_by(card_id: self.card.id)
				lc = user.tradeable_list.listed_cards.find_by(card_id: self.card.id)
				lc.amount += qty + self.amount
				lc.save
				# self.destroy
				binding.pry
			# If receiving user does NOT have th ecard in their tradeable_list
			elsif user.tradeable_list.listed_cards.find_by(card_id: self.card.id) == nil
				new_listed_card = ListedCard.create
				new_listed_card.card = self.card
				new_listed_card.amount = qty + self.amount
				new_listed_card.tradeable_list = user.tradeable_list
				new_listed_card.save
				user.save
				# self.destroy
				binding.pry
			else
				raise "how did you mess up this bad?"
			end
			self.remove(qty)
		end
	end

end










