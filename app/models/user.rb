class User
  include Mongoid::Document
  include Mongoid::Attributes::Dynamic

  has_and_belongs_to_many :tradeable_cards, class_name: 'Card', inverse_of: :tradeable_by
  has_and_belongs_to_many :wanted_cards, class_name: 'Card', inverse_of: :wanted_by    
  has_many :comments

  field :first_name, type: String
  field :last_name,  type: String
  field :email,      type: String
  field :dci_number, type: Integer

end
