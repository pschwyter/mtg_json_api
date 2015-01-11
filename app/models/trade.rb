class Trade < ActiveRecord::Base
	belongs_to :initiator, class_name: 'User'
	belongs_to :receiver, class_name: 'User'

	belongs_to :initiator_list, class_name: "List"
	belongs_to :receiver_list, class_name: "List"

	# before_save :replace_nil_with_array
	before_save :update_trade_status

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
			self.initiator == current_user ? "Waiting for approval from you" :
			"Waiting for #{self.initiator.full_name}"
		elsif self.receiver_accepted == false
			self.receiver == current_user ? "Waiting for approval from you" :
			"Waiting for #{self.receiver.full_name}"
		end
	end

	private

	# def replace_nil_with_array
	# 	binding.pry
	# 	if self.cards_from_initiator == nil
	# 		self.cards_from_initiator = []
	# 	end
	# 	if self.cards_from_receiver == nil
	# 		self.cards_from_receiver = []
	# 	end
	# 	binding.pry
	# end

	def update_trade_status
		if self.initiator_accepted == true && self.receiver_accepted == true
			self.status = "complete"
		end
	end

end







