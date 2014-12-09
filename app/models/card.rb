class Card
  include Mongoid::Document
  include Mongoid::Attributes::Dynamic

  has_and_belongs_to_many :users

  # field :card, type: array
  # Don't think I need to specify fields, bra
  # field :layout, type: string
  # field :type, type: string
  # field :types, type: array
  # field :layout, type: string
  # field :layout, type: string
  # field :layout, type: string
  # field :layout, type: string

end
