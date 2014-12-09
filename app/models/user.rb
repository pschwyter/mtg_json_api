class User
  include Mongoid::Document

  has_and_belongs_to_many :tradeable_cards, class_name: 'Card'
  has_and_belongs_to_many :wanted_cards, class_name: 'Card' #type: Hash?  
  # has_many :cards, as: :binder #type: Hash?  
  
  field :first_name, type: String
  field :last_name,  type: String
  field :email,      type: String
  field :dci_number, type: Integer
  #field :tradeable_cards, type: Array
end
