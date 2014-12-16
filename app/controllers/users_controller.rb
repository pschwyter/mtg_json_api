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
  new_card = current_user.listed_cards.build(card_id: params[:card_id])
  new_card.status = 1
  new_card.save
  redirect_to "/users/#{current_user.id}"
end

def add_to_wanted
  new_card = current_user.listed_cards.build(card_id: params[:card_id])
  new_card.status = 0
  new_card.save
  redirect_to "/users/#{current_user.id}"
end

def remove_from_tradeable
  current_user.listed_cards.where(status: 1).where(card_id: params[:card_id]).first.delete
  redirect_to "/users/#{current_user.id}"
end

def remove_from_wanted
  current_user.wanted_cards.where(status: 0).find(params[:card_id]).first.delete
  redirect_to "/users/#{current_user.id}"
end

def destroy
end

def whereami
  current_user.update_attributes(:latitude => params[:lato], :longitude => params[:longo] )


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