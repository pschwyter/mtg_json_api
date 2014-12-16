class ListedCard < ActiveRecord::Base
	belongs_to :card
	belongs_to :user
	belongs_to :trade
end

