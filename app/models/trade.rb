class Trade
  include Mongoid::Document
  include Mongoid::Attributes::Dynamic

  belongs_to :initiator, class_name: 'User'
  belongs_to :receiver, class_name: 'User'
  has_many :comments

  field :initiator_cards, type: Array, default: []
  field :receiver_cards, type: Array, default: []

  # {
  # 	trade: [
  # 		[User, [cards]],
  # 		[User, [cards]],
  # 	]
  # 	comments: [ Comment, ... ],
  # }

end
