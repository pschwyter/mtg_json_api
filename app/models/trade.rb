class Trade < ActiveRecord::Base
	belongs_to :initiator, class_name: 'User'
	belongs_to :receiver, class_name: 'User'

	before_save :replace_nil_with_array
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
		receiver_cards_to_trade = self.cards_from_receiver.map {|card_id| ListedCard.find(card_id)} 

		initiator_user = self.initiator
		receiver_user = self.receiver

		initiator_cards_to_trade.each do |card| 
			p card.user
			card.user = self.receiver
			card.save
			p card.user
		end
		receiver_cards_to_trade.each do |card| 
			p card.user
			card.user = self.initiator
			card.save
			p card.user
		end
		self.save
	end

	private

	def replace_nil_with_array
		if self.cards_from_initiator == nil
			self.cards_from_initiator = []
		end
		if self.cards_from_receiver == nil
			self.cards_from_receiver = []
		end
	end

	def update_trade_status
		if self.initiator_accepted == true && self.receiver_accepted == true
			self.status = "complete"
		end
	end

end







