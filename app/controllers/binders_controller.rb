class BindersController < ApplicationController
 

def index

end

def show
@card = Card.find(params[:id])
@users = User.all
end


end
