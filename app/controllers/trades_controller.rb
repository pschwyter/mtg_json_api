class TradesController < ApplicationController

	def show
		@trade = Trade.find(params[:id])
	end

	def index
		@trades = Trade.where(initiator_id: current_user.id)
	end

	def new
		@user = User.find(params[:user_id])
		@trade = Trade.new
	end

	def create
		@trade = Trade.create(receiver_id: params[:user_id], 
							  cards_from_initiator: params[:cards_from_initiator],
							  cards_from_receiver: params[:cards_from_receiver]
							  )
		@trade.initiator = current_user
		if @trade.save
			redirect_to user_trades_path(current_user.id)
		end
	end

	def edit
		@trade = Trade.find(params[:id])
		@user = @trade.receiver
	end

	def update
		@trade = Trade.find(params[:id])
		@trade.update(cards_from_initiator: params[:cards_from_initiator],
							  cards_from_receiver: params[:cards_from_receiver]
							  )
		if @trade.save
			redirect_to user_trades_path(current_user.id)
		end
	end

	def destroy
	end

	private

end





