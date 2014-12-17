class TradesController < ApplicationController

	def show
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
							  start_initiator_list: params[:start_initiator_list],
							  start_receiver_list: params[:start_receiver_list]
							  )
		@trade.initiator = current_user
		if @trade.save
			binding.pry
			redirect_to user_trades_path(current_user.id)
		end
	end

	def edit
		@trade = Trade.find(params[:id])
		@user = @trade.receiver
		binding.pry
	end

	def update
	end

	def destroy
	end

	private

end





