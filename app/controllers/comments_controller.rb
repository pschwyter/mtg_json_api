class CommentsController < ApplicationController

	def new
		@comment = Comment.new
	end

	def create

		@comment = Comment.create(comment_params)
		@comment.trade = Trade.find(params[:trade_id])
		@comment.user = current_user
		@comment.save
		
	  respond_to do |format|
	    format.js
	  end
	end

	def index
		@trade = Trade.find(params[:trade_id])
		@comments = @trade.comments
		
		if params[:last_comment_id] != '0'
			@trade.comments.each do |comment|
				unless comment.user == current_user
					comment.viewed = true
					comment.save
				end
			end
		end
		# binding.pry
		respond_to do |format|
			format.js
		end
	end

	private

	def comment_params
		params.require(:comment).permit(:body)		
	end

end
