class UsersController < ApplicationController

def new
	@user = User.new
end

def create
    @user = User.new(user_params)
    if @user.save
      redirect_to new_user_url, notice: "Signed up!"
    else
      render "new"
    end
end

def show
  @place_holder_user = User.last 
end

def edit
end

def update
end

def add_to_tradeable
  current_user.tradeable_cards << Card.find(params[:card_id])
  redirect_to "/users/#{current_user.id}"
end

def add_to_wanted
  current_user.wanted_cards << Card.find(params[:card_id])
  redirect_to "/users/#{current_user.id}"
end

def remove_from_tradeable
  current_user.tradeable_cards.find(params[:card_id]).remove
  redirect_to "/users/#{current_user.id}"
end

def remove_from_wanted
  current_user.wanted_cards.find(params[:card_id]).remove
  redirect_to "/users/#{current_user.id}"
end

def destroy
end

def whereami
  long = params[:lato].to_f
  lat = params[:longo].to_f
  current_user.update_attributes(coordinates:[long,lat])


  # if current_user.location_history
  #   current_user.location_history << coords
  #   current_user.save
  # else
  #   current_user.location_history = coords
  #   current_user.save
  # end

end

private
  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :dci_number, :password, :password_confirmation)
  end


end
