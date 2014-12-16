class ListedCard < ActiveRecord::Base
	belongs_to :card
	belongs_to :list
end

