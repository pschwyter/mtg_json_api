class Trade
  include Mongoid::Document
  include Mongoid::Attributes::Dynamic

  belongs_to :initatior, class_name: 'User'
  belongs_to :receiver, class_name: 'User'

  # has_many :initiator_cards, class_name: 'Card'
  # has_many :receiver_cards, class_name: 'Card'

  field :initiator_cards, type: Array
  field :receiver_cards, type: Array

  # {
  # 	trade: [
  # 		[User, [cards]],
  # 		[User, [cards]],
  # 	]
  # 	comments: [ Comment, ... ],
  # }

end
