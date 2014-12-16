class User < ActiveRecord::Base
  authenticates_with_sorcery!

  validates_confirmation_of :password
  validates_presence_of :password, :on => :create
  validates_presence_of :email
  validates_uniqueness_of :email

  after_validation :geocode

  reverse_geocoded_by :latitude, :longitude 
  
  has_many :listed_cards
  has_many :trades
end


