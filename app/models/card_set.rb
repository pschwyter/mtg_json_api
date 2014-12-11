class CardSet
  include Mongoid::Document
  include Mongoid::Attributes::Dynamic

  has_many :cards
  
end
