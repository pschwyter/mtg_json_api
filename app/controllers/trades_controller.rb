class TradesController < ApplicationController

	def show
		@trade = Trade.find(params[:id])
		@comment = Comment.new()
		@user = @trade.other_user(current_user)

		if @trade.initiator == current_user
			@user_status = "receiver"
			@current_user_status = "initiator"
		else
			@user_status = "initiator"
			@current_user_status = "receiver"
		end

		# For cancelled or completed trades
		@cards_from_initiator = Card.where(id: @trade.card_ids_from_initiator.map{|i| i})
		@cards_from_receiver = Card.where(id: @trade.card_ids_from_receiver.map{|i| i})

	end

	def index
		@user = current_user
		@trades = Trade.where("(initiator_id = ? or receiver_id = ?)", current_user.id, current_user.id)
	end


	def new
		@user = User.find(params[:user_id])
		@trade = @user.received_trades.new(initiator: current_user,
																			 cards_from_initiator: current_user.tradeable_cards.map{|listed_card| listed_card.id},
																			 cards_from_receiver: @user.tradeable_cards.map{|listed_card| listed_card.id},
																			 qty_from_initiator:  current_user.tradeable_cards.map{|listed_card| 0},
																			 qty_from_receiver:  @user.tradeable_cards.map{|listed_card| 0}
																			 )
		if @trade.initiator == current_user
			@user_status = "receiver"
			@current_user_status = "initiator"
		else
			@user_status = "initiator"
			@current_user_status = "receiver"
		end
	end

	def create
		@user = User.find(params[:user_id])
		@trade = @user.received_trades.create(initiator: current_user)
		
		trade_params[:cards_from_initiator].each {|k| @trade.update_attributes(cards_from_initiator: (@trade.cards_from_initiator + [k]))}
		trade_params[:cards_from_receiver].each {|k| @trade.update_attributes(cards_from_receiver: (@trade.cards_from_receiver + [k]))}
		trade_params[:qty_from_initiator].each {|k| @trade.update_attributes(qty_from_initiator: (@trade.qty_from_initiator + [k]))}
		trade_params[:qty_from_receiver].each {|k| @trade.update_attributes(qty_from_receiver: (@trade.qty_from_receiver + [k]))}
		
		@trade.update_attributes(card_ids_from_initiator: @trade.cards_from_initiator.map{|listed_card| ListedCard.find(listed_card).card_id})
		@trade.update_attributes(card_ids_from_receiver: @trade.cards_from_receiver.map{|listed_card| ListedCard.find(listed_card).card_id})

		@trade.update_listed_cards
		@trade.accept(current_user)

		if @trade.save
			redirect_to user_trades_path(current_user.id)
		else
			raise "error"
		end
	end

	def edit
		Trade.find(params[:id])
		@trade = Trade.find(params[:id])
		@user = @trade.other_user(current_user)

		if @trade.initiator == current_user
			@user_status = "receiver"
			@current_user_status = "initiator"
		else
			@user_status = "initiator"
			@current_user_status = "receiver"
		end

	end

	def update
		@trade = Trade.find(params[:id])
		@user = @trade.other_user(current_user)
		
		@trade.update_attributes(qty_from_initiator: (trade_params[:qty_from_initiator].map{|i| i}))
		@trade.update_attributes(qty_from_receiver: (trade_params[:qty_from_receiver].map{|i| i}))
	
		@trade.update_attributes(card_ids_from_initiator: @trade.cards_from_initiator.map{|listed_card| ListedCard.find(listed_card).card_id})
		@trade.update_attributes(card_ids_from_receiver: @trade.cards_from_receiver.map{|listed_card| ListedCard.find(listed_card).card_id})

		@trade.accept(current_user)
		reset_other_user_status
		
		@trade.update_listed_cards
		if @trade.save
			redirect_to user_trades_path(current_user.id)
		else
			raise "error"
		end
	end

	def cancel
		@trade = Trade.find(params[:id])
		@trade.status = "cancelled"
		@trade.save
		@trade.update_listed_cards
		redirect_to user_trades_path(current_user)
	end

	def accept
		@trade = Trade.find(params[:id])
		if @trade.initiator == current_user
			@trade.initiator_accepted = true
		elsif @trade.receiver == current_user
			@trade.receiver_accepted = true
		end

		@trade.save
		check_if_complete

		redirect_to user_trades_path(current_user.id)
	end

	def show_trades_with_status
		@user = current_user
		status = params[:status]
		@trades = Trade.where("(initiator_id = ? or receiver_id = ?)", current_user.id, current_user.id).where(status: status)
		respond_to do |format|
			format.js
		end
	end

	private

	# During a new trade creation, if list is left blank params[:trade] will be missing one or both card_from arrays (ie. nil)
	# and that will cause Trade creation to break
	# Just realize that I should wrap the whole thing in an if statement, but too tired, FIX TOMORROW
	# (params[:trade].has_key?(:cards_from_initiator) ? cards_from_initiator: params[:trade][:cards_from_initiator] : cards_from_initiator: [] )
	def raw_trade_params
		if params.has_key?(:trade)
		{
			cards_from_initiator: 	(params[:trade].has_key?(:cards_from_initiator) ? params[:trade][:cards_from_initiator] : [] ),
			cards_from_receiver: 	(params[:trade].has_key?(:cards_from_receiver) ? params[:trade][:cards_from_receiver] : [])
		}
		else
			params[:trade] = {cards_from_initiator: {}, cards_from_receiver: {}}
		end
	end

	def trade_params
		Hash[
			 cards_from_initiator: raw_trade_params.map {|k,v| v}[0].map{|k,v| k.to_i}, 
			 cards_from_receiver: raw_trade_params.map {|k,v| v}[1].map{|k,v| k.to_i},
			 qty_from_initiator: raw_trade_params.map {|k,v| v}[0].map{|k,v| v.to_i},
			 qty_from_receiver: raw_trade_params.map {|k,v| v}[1].map{|k,v| v.to_i}
			]
	end

	def reset_other_user_status
		if @trade.other_user(current_user) == @trade.initiator
			@trade.initiator_accepted = false
		elsif @trade.other_user(current_user) == @trade.receiver
			@trade.receiver_accepted = false
		end
	end

	def check_if_complete
		if @trade.status == "complete"
			@trade.exchange_cards
			@trade.update_listed_cards
			@trade.update_other_trades_on_completion
		end
	end

end
