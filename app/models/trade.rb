class Trade < ActiveRecord::Base
	belongs_to :initiator, class_name: 'User'
	belongs_to :receiver, class_name: 'User'

	belongs_to :initiator_list, class_name: "List"
	belongs_to :receiver_list, class_name: "List"

	has_many :comments

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
		initiator_cards_to_trade = self.cards_from_initiator.map do |card_id| 
			if card_id == nil
				nil
			else
				ListedCard.find(card_id)
			end
		end
		initiator_qty_to_trade = self.qty_from_initiator
		receiver_cards_to_trade = self.cards_from_receiver.map do |card_id| 
			if card_id == nil
				nil
			else
				ListedCard.find(card_id)
			end
		end
		receiver_qty_to_trade = self.qty_from_receiver
		i = 0
		initiator_cards_to_trade.each do |listed_card| 
			unless initiator_qty_to_trade[i] == 0 || listed_card == nil
				listed_card.trade_to(self.receiver, initiator_qty_to_trade[i])
			end
			i += 1
		end

		i = 0
		receiver_cards_to_trade.each do |listed_card| 
			unless receiver_qty_to_trade[i] == 0 || listed_card == nil
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
		elsif self.initiator == current_user
			if self.initiator_accepted == true
				"Waiting for #{self.receiver.full_name}"
			elsif self.initiator_accepted == false
				if self.initiator_viewed == true
					"Waiting for you"
				elsif self.initiator_viewed == false
					"Trade modified by #{self.receiver.full_name}"
				end
			end	
		elsif self.receiver == current_user
			if self.receiver_accepted == true
				"Waiting for #{self.initiator.full_name}"
			elsif self.receiver_accepted == false
				if self.receiver_viewed == true
					"Waiting for you"
				elsif self.receiver_viewed == false && self.last_edit_by == "initiator"
					"Trade modified by #{self.initiator.full_name}"
				end
			end
		end
	end

	def initiator_cards_wanted_by_receiver
		wanted_cards = self.receiver.wanted_cards
		tradeable_cards = self.initiator.tradeable_cards
		[wanted_cards, tradeable_cards].inject(&:&)

	end

	def receiver_cards_wanted_by_initiator
		wanted_cards = self.initiator.wanted_cards
		tradeable_cards = self.receiver.tradeable_cards
		[wanted_cards, tradeable_cards].inject(&:&)

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
				if self.qty_from_initiator[i] != nil && self.qty_from_initiator[i] > 0 && ListedCard.exists?(id)
					listed_card = ListedCard.find(id)
					listed_card.update_attributes(active_trades: (listed_card.active_trades.reject{|i| i == self.id}))

				end
				i += 1
			end
			i = 0
			self.cards_from_receiver.each do |id|
				if self.qty_from_receiver[i] != nil && self.qty_from_receiver[i] > 0 && ListedCard.exists?(id)
					listed_card = ListedCard.find(id)
					listed_card.update_attributes(active_trades: (listed_card.active_trades.reject{|i| i == self.id}))

				end
				i += 1
			end
		end
	end

	def get_cards_from_card_ids(user_status)
		cards = self.send("card_ids_from_#{user_status}").map {|card_id| Card.find(card_id)}
		cards
	end

	def listed_card_qty_in_trade(listed_card, user_status)
		index = self.send("cards_from_#{user_status}").index(listed_card.id)
		unless index == nil
			self.send("qty_from_#{user_status}")[index]
		end
	end

	def card_qty_in_trade(card_id, user_status)
		index = self.send("card_ids_from_#{user_status}").index(card_id)
		self.send("qty_from_#{user_status}")[index]
	end

	def card_value_difference_string(user)

		if self.initiator == user
			user_status = "initiator"
		elsif self.receiver == user
			user_status = "receiver"
		end

		actual_cards_from_initiator = self.card_ids_from_initiator.map{|card_id| Card.find(card_id)}
		actual_cards_from_receiver = self.card_ids_from_receiver.map{|card_id| Card.find(card_id)}
		qty_from_initiator = self.qty_from_initiator
		qty_from_receiver = self.qty_from_receiver

		i = 0
		initiator_value = 0
		qty_from_initiator.each do |qty|
			initiator_value += qty * actual_cards_from_initiator[i].price
			i += 1
		end
		j = 0
		receiver_value = 0
		qty_from_receiver.each do |qty|
			receiver_value += qty * actual_cards_from_receiver[j].price
			j += 1
		end

		if user_status == "initiator"
			diff = initiator_value - receiver_value
		elsif user_status == "receiver"
			diff = receiver_value - initiator_value 
		end

		if diff > 0
			"- $ " + diff.abs.to_s
		else
			"+ $ " + diff.abs.to_s
		end

	end


	# Updated cards_from and qty_from in all other trades after trade is completed
	def update_other_trades_on_completion
		if self.status == "complete"
			# initiator = self.initiator
			listed_cards_from_initiator = self.cards_from_initiator.map {|listed_card_id| listed_card_id if ListedCard.exists?(listed_card_id) }
			listed_cards_from_receiver = self.cards_from_receiver.map {|listed_card_id| listed_card_id if ListedCard.exists?(listed_card_id) }

			# receiver = self.receiver
			# cards_from_receiver = self.cards_from_receiver

			initiator_trades = initiator.initiated_trades.where(status: "pending") + initiator.received_trades.where(status: "pending")
			receiver_trades = receiver.initiated_trades.where(status: "pending") + receiver.received_trades.where(status: "pending")

			# remove listed_card_id if it no longer exists
			initiator_trades.each do |trade|
				if self.initiator == trade.initiator
					trade.update_attributes(cards_from_initiator: listed_cards_from_initiator)

				elsif self.initiator == trade.receiver
					trade.update_attributes(cards_from_receiver: listed_cards_from_initiator)
				end
			end

			receiver_trades.each do |trade|
				if self.receiver == trade.receiver
					trade.update_attributes(cards_from_receiver: listed_cards_from_receiver)

				elsif self.receiver == trade.initiator
					trade.update_attributes(cards_from_initiator: listed_cards_from_receiver)
				end
			end
		end
	end

	def get_user_status(user)
		if self.initiator == user
			'initiator'
		elsif self.receiver == user
			'receiver'
		end
	end

	def has_unviewed_comments(user)
		arr = self.comments.select do |comment|
			true if (comment.user != user && comment.viewed == false )
		end
		true if arr.length > 0
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




