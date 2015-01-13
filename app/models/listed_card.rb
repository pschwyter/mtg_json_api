class ListedCard < ActiveRecord::Base
	belongs_to :card
	belongs_to :list

	after_save :destroy_if_amount_zero
	after_save :reconcile_inventory_and_trade
	
	# should a ListedCard belong to a list?????

	def move_to(user, list)
		# self.
	end

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
			# If receiving user already has the card in their inventory_list
			if user.inventory_list.listed_cards.find_by(card_id: self.card.id) != nil
				lc = user.inventory_list.listed_cards.find_by(card_id: self.card.id)
				lc.amount += qty
				lc.save
			# If receiving user does NOT have th ecard in their inventory_list
			elsif user.inventory_list.listed_cards.find_by(card_id: self.card.id) == nil
				user.inventory_list.listed_cards.build(card: self.card, amount: qty)
				user.inventory_list.save
				# user.save
			else
				raise "how did you mess up this bad?"
			end

		elsif self.amount < 1
			if user.inventory_list.listed_cards.find_by(card_id: self.card.id)
				lc = user.inventory_list.listed_cards.find_by(card_id: self.card.id)
				lc.amount += qty + self.amount
				lc.save
				# self.destroy
			# If receiving user does NOT have th ecard in their inventory_list
			elsif user.inventory_list.listed_cards.find_by(card_id: self.card.id) == nil
				user.inventory_list.listed_cards.build(card: self.card, amount: qty)
				user.inventory_list.save
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

	# def find_active_trades
	# 	self.active_trades.map do |trade_id|
	# 		Trade.find(trade_id) if Trade.find(trade_id).status == "pending"
	# 	end
	# end

	def reconcile_inventory_and_trade
		user = self.list.user
		if self.list.name == "tradeable_list"
			if user.inventory_cards.find_by(card_id: self.card_id)
				inventory_card = user.inventory_cards.find_by(card_id: self.card_id)
				if inventory_card.amount < self.amount
					inventory_card.amount = self.amount
					inventory_card.save
				end
			else
				inventory_card = ListedCard.create(list: user.inventory_list, amount: self.amount, card_id: self.card_id)
			end	 
		elsif self.list.name == "inventory_list"
			if user.tradeable_cards.find_by(card_id: self.card_id)
				tradeable_card = user.tradeable_cards.find_by(card_id: self.card_id)
				if tradeable_card.amount > self.amount
					tradeable_card.amount = self.amount
					tradeable_card.save
				end
			end
		end
	end
end










