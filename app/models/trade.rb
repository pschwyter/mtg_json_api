class Trade < ActiveRecord::Base
	belongs_to :initiator, class_name: 'User'
	belongs_to :receiver, class_name: 'User'
	has_many :initiator_cards, class_name: 'ListedCard'
	has_many :receiver_cards, class_name: 'ListedCard'
end
