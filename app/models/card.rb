class Card
  include Mongoid::Document
  include Mongoid::Attributes::Dynamic

  belongs_to :card_set
  has_and_belongs_to_many :tradeable_by, class_name: 'User', inverse_of: :tradeable_cards
  has_and_belongs_to_many :wanted_by, class_name: 'User', inverse_of: :wanted_cards

  # THE CONCEPT BELOW SHOULD BE ADDED TO THE USER!!!????
  # In order for a user to place multiple "copies" of a card into either list
  # add a new attribute to card, ie. "copies_by_user_ids". 
  # card['tradeable_copies_by_user_ids'] = []; card.save
  # card['wanted_copies_by_user_ids'] = []; card.save

  # We then push the user.id to this array a number of times equal to the copies
  # of that card in that list (tradeable_cards / wanted_cards)

end
