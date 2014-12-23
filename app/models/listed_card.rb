class ListedCard < ActiveRecord::Base
	belongs_to :card
	belongs_to :list
	belongs_to :tradeable_list, class_name: "List"
	belongs_to :wanted_list, class_name: "List" 
	belongs_to :inventory_list, class_name: "List"
	before_save :destroy_if_amount_zero 
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
		# If amount in listed_card will be at least 1 after trade
		if self.amount >= 1 
			# If receiving user already has the card in their tradeable_list
			if user.tradeable_list.listed_cards.find_by(card_id: self.card.id) != nil
				lc = user.tradeable_list.listed_cards.find_by(card_id: self.card.id)
				lc.amount += qty
				lc.save
			# If receiving user does NOT have th ecard in their tradeable_list
			elsif user.tradeable_list.listed_cards.find_by(card_id: self.card.id) == nil
				user.tradeable_list.listed_cards.build(card: self.card, amount: qty)
				user.tradeable_list.save
				# user.save
			else
				raise "how did you mess up this bad?"
			end

		elsif self.amount < 1
			if user.tradeable_list.listed_cards.find_by(card_id: self.card.id)
				lc = user.tradeable_list.listed_cards.find_by(card_id: self.card.id)
				lc.amount += qty + self.amount
				lc.save
				# self.destroy
			# If receiving user does NOT have th ecard in their tradeable_list
			elsif user.tradeable_list.listed_cards.find_by(card_id: self.card.id) == nil
				user.tradeable_list.listed_cards.build(card: self.card, amount: qty)
				user.tradeable_list.save
				# user.save
			else
				raise "how did you mess up this bad?"
			end
		end
			self.remove(qty)
			self.save
	end

	private

	def destroy_if_amount_zero
		self.destroy if self.amount <= 0
	end

end










