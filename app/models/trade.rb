class Trade < ActiveRecord::Base
	belongs_to :initiator, class_name: 'User'
	belongs_to :receiver, class_name: 'User'

	belongs_to :initiator_list, class_name: "List"
	belongs_to :receiver_list, class_name: "List"

	# before_save :replace_nil_with_array
	before_save :update_trade_status
	before_save :prevent_nil_array

	def accept(user)
		if self.initiator == user
			self.initiator_accepted = true
		elsif self.receiver == user
			self.receiver_accepted = true
		end
	end

	def other_user(current_user)
		if self.initiator == current_user
			@@other_user = self.receiver
			self.receiver
		elsif self.receiver == current_user
			@@other_user = self.initiator
			self.initiator
		end
	end

	def exchange_cards
		initiator_cards_to_trade = self.cards_from_initiator.map {|card_id| ListedCard.find(card_id)}
		initiator_qty_to_trade = self.qty_from_initiator
		receiver_cards_to_trade = self.cards_from_receiver.map {|card_id| ListedCard.find(card_id)} 
		receiver_qty_to_trade = self.qty_from_receiver
		i = 0
		initiator_cards_to_trade.each do |listed_card| 
			unless initiator_qty_to_trade[i] == 0
				listed_card.trade_to(self.receiver, initiator_qty_to_trade[i])
			end
			i += 1
		end

		i = 0
		receiver_cards_to_trade.each do |listed_card| 
			unless receiver_qty_to_trade[i] == 0
				listed_card.trade_to(self.initiator, receiver_qty_to_trade[i])
			end
			i += 1
		end

		self.save
	end

	def display_status(current_user)
		if self.status == "complete"
			"Complete!"
		elsif self.status == "cancelled"
			"Trade Cancelled"
		elsif self.initiator_accepted == false
			self.initiator == current_user ? "Waiting for you" :
			"Waiting for #{self.initiator.full_name}"
		elsif self.receiver_accepted == false
			self.receiver == current_user ? "Waiting for you" :
			"Waiting for #{self.receiver.full_name}"
		end
	end

	def initiator_cards_wanted_by_receiver
		wanted_cards = self.receiver.wanted_cards
		tradeable_cards = self.initiator.tradeable_cards
		[wanted_cards, tradeable_cards].inject(&:&)
		binding.pry
	end

	def receiver_cards_wanted_by_initiator
		wanted_cards = self.initiator.wanted_cards
		tradeable_cards = self.receiver.tradeable_cards
		[wanted_cards, tradeable_cards].inject(&:&)
		binding.pry
	end

	def update_listed_cards
		if self.status == "pending"
			i = 0
			self.cards_from_initiator.each do |id|
				if self.qty_from_initiator[i] != nil && self.qty_from_initiator[i] > 0
					listed_card = ListedCard.find(id)
					listed_card.update_attributes(active_trades: (listed_card.active_trades + [self.id]))
				end
				i += 1
			end
			i = 0
			self.cards_from_receiver.each do |id|
				if self.qty_from_receiver[i] != nil && self.qty_from_receiver[i] > 0
					listed_card = ListedCard.find(id)
					listed_card.update_attributes(active_trades: (listed_card.active_trades + [self.id]))

				end
				i += 1
			end
		end

		if self.status == "complete" || self.status == "cancelled"
			i = 0

			self.cards_from_initiator.each do |id|
				if self.qty_from_initiator[i] != nil && self.qty_from_initiator[i] > 0
					listed_card = ListedCard.find(id)
					listed_card.update_attributes(active_trades: (listed_card.active_trades.reject{|i| i == self.id}))

				end
				i += 1
			end
			i = 0
			self.cards_from_receiver.each do |id|
				if self.qty_from_receiver[i] != nil && self.qty_from_receiver[i] > 0
					listed_card = ListedCard.find(id)
					listed_card.update_attributes(active_trades: (listed_card.active_trades.reject{|i| i == self.id}))

				end
				i += 1
			end
		end
	end

	private

	def update_trade_status
		if self.initiator_accepted == true && self.receiver_accepted == true
			self.status = "complete"
		end
	end

	def prevent_nil_array
		if self.cards_from_initiator == nil
			self.update_attributes(cards_from_initiator: [])
		end
		if self.cards_from_receiver == nil
			self.update_attributes(cards_from_receiver: [])
		end
		if self.qty_from_initiator == nil
			self.update_attributes(qty_from_initiator: [])
		end
		if self.qty_from_receiver == nil
			self.update_attributes(qty_from_receiver: [])
		end
	end

end




