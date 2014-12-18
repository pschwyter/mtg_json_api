class TradesController < ApplicationController

	def show
		@trade = Trade.find(params[:id])
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
		@trade = @user.received_trades.build(trade_params)
		@trade.initiator = current_user
		if @trade.save
			redirect_to user_trades_path(current_user.id)
		end
	end

	def edit
		Trade.find(params[:id]).save
		@trade = Trade.find(params[:id])
		@user = @trade.receiver
	end

	def update
		@trade = Trade.find(params[:id])
		@trade.update(trade_params)
		if @trade.save
			redirect_to user_trades_path(current_user.id)
		end
	end

	def destroy
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
			 cards_from_initiator: raw_trade_params.map {|k,v| v.map {|i| i.to_i}}[0], 
			 cards_from_receiver: raw_trade_params.map {|k,v| v.map {|i| i.to_i}}[1]
			]
	end

end




