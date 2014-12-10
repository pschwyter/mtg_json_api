class Comment
  include Mongoid::Document
  include Mongoid::Attributes::Dynamic 
  
  belongs_to :trade
  belongs_to :user

  field :content, type: String

end
