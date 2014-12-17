class User < ActiveRecord::Base
  authenticates_with_sorcery!

validates_confirmation_of :password
validates_presence_of :password, :on => :create
validates_presence_of :email
validates_uniqueness_of :email

reverse_geocoded_by :latitude, :longitude
# convert these to address in geocoddec_position

after_validation :reverse_geocode

has_many :listed_cards
has_many :trades
end


