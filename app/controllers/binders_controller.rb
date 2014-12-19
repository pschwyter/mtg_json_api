class BindersController < ApplicationController
 

def index

end

def show
@cards = Card.find(params[:id])
@users = match_users

end

private

def match_users
	listed_cards = ListedCard.where(card_id: (params[:id])) 
	result = []
	listed_cards.each {|listed_card| result << listed_card unless listed_card.tradeable_list_id == nil}
	users = []
	result.each {|card| users << card.tradeable_list.user}

	users = User.where(id: users.map(&:id))

	users
end


end
