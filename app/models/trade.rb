class Trade < ActiveRecord::Base
	belongs_to :initiator, class_name: 'User'
	belongs_to :receiver, class_name: 'User'
	has_many :cards_from_initiator, class_name: 'ListedCard', :foreign_key => 'trade_by_initiator_id'
	has_many :cards_from_receiver, class_name: 'ListedCard', :foreign_key => 'trade_by_receiver_id'

end
