class Trade
  include Mongoid::Document

  belongs_to :initatior, class_name: 'User'
  belongs_to :receiver, class_name: 'User'

  has_many :cards


  # {
  # 	trade: [
  # 		[User, [cards]],
  # 		[User, [cards]],
  # 	]
  # 	comments: [ Comment, ... ],
  # }

end
