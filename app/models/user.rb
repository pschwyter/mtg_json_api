   

class User
  include Mongoid::Document
  include Mongoid::Attributes::Dynamic
  include ActiveModel::SecurePassword

has_secure_password
  

  has_and_belongs_to_many :tradeable_cards, class_name: 'Card', inverse_of: :tradeable_by
  has_and_belongs_to_many :wanted_cards, class_name: 'Card', inverse_of: :wanted_by    
  
  field :first_name, type: String
  field :last_name,  type: String
  field :email,      type: String
  field :dci_number, type: Integer
  field :password_digest, type: String
  field :coordinates, type: Array, :default => []
  # field :address, type: String #or is it an array? 
  # field :location_history 
  # def coordinates; location_history ? location_history.last : []; end


  include Geocoder::Model::Mongoid
  reverse_geocoded_by :coordinates
  after_validation :reverse_geocode

end