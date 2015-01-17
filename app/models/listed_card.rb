class ListedCard < ActiveRecord::Base
	belongs_to :card
	belongs_to :list

	after_save :destroy_if_amount_zero
	after_save :reconcile_inventory_and_trade
	
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
		original_owner = self.list.user
		# Remove qty from the original_owners inventory list as well
		if original_owner.inventory_cards.find_by(card_id: self.card_id)
			original_owner.inventory_cards.find_by(card_id: self.card_id).remove(qty)
		end
		card = self.card
		self.remove(qty)

		# If receiving user already has the card in their inventory_list
		if user.inventory_list.listed_cards.find_by(card_id: card.id)
			lc = user.inventory_list.listed_cards.find_by(card_id: card.id)
			lc.add(qty)
		# If receiving user does NOT have the card in their inventory_list
		elsif user.inventory_list.listed_cards.find_by(card_id: card.id) == nil
			user.inventory_list.listed_cards.build(card: card, amount: qty)
			user.inventory_list.save
		else
			raise "how did you mess up this bad?"
		end
	end

	private

	def destroy_if_amount_zero
		self.destroy if self.amount <= 0
	end

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










