class TradesController < ApplicationController

	def show
		@trade = Trade.find(params[:id])
		@user = @trade.other_user(current_user)
	end

	def index
		@trades = Trade.where("(initiator_id = ? or receiver_id = ?)", current_user.id, current_user.id)
	end


	def new
		@user = User.find(params[:user_id])
		@trade = @user.received_trades.new
	end

	def create
		@user = User.find(params[:user_id])
		@trade = @user.received_trades.create
		trade_params[:cards_from_initiator].each {|k| @trade.update_attributes(cards_from_initiator: (@trade.cards_from_initiator + [k]))}
		trade_params[:cards_from_receiver].each {|k| @trade.update_attributes(cards_from_receiver: (@trade.cards_from_receiver + [k]))}
		trade_params[:qty_from_initiator].each {|k| @trade.update_attributes(qty_from_initiator: (@trade.qty_from_initiator + [k]))}
		trade_params[:qty_from_receiver].each {|k| @trade.update_attributes(qty_from_receiver: (@trade.qty_from_receiver + [k]))}
		@trade.initiator = current_user
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
	end

	def update
		@trade = Trade.find(params[:id])
		@user = @trade.other_user(current_user)
		trade_params[:cards_from_initiator].each {|k| @trade.update_attributes(cards_from_initiator: (@trade.cards_from_initiator + [k]))}
		trade_params[:cards_from_receiver].each {|k| @trade.update_attributes(cards_from_receiver: (@trade.cards_from_receiver + [k]))}
		trade_params[:qty_from_initiator].each {|k| @trade.update_attributes(qty_from_initiator: (@trade.qty_from_initiator + [k]))}
		trade_params[:qty_from_receiver].each {|k| @trade.update_attributes(qty_from_receiver: (@trade.qty_from_receiver + [k]))}
		@trade.accept(current_user)
		reset_other_user_status
		binding.pry
		if @trade.save
			redirect_to user_trades_path(current_user.id)
		else
			raise "error"
		end
	end

	def destroy
	end

	def accept
		@trade = Trade.find(params[:id])
		if @trade.initiator == current_user
			@trade.initiator_accepted = true
		elsif @trade.receiver == current_user
			@trade.receiver_accepted = true
		end
		binding.pry
		@trade.save
		check_if_complete
		binding.pry
		redirect_to user_trades_path(current_user.id)
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
			params[:trade] = {cards_from_initiator: [], cards_from_receiver: []}
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
		end
	end

end




