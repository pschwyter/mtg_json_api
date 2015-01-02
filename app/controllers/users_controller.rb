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

def index
  @users = User.all
end

def show
  @user = User.find(params[:id])
  c_position = [current_user.latitude, current_user.longitude]
  @current_position = User.near(c_position, 10, units: :km)

  # @distance = current_user.distance_between(current_user, User.all) 
end

def edit
end

def update
  @user = current_user
  if tradeable_params
    tradeable_params.each do |key, value| 
      listed_card = @user.tradeable_cards.find(value['id'])
      listed_card.amount = value['amount'].to_i
      listed_card.save
    end
  elsif wanted_params
    wanted_params.each do |key, value| 
      listed_card = @user.wanted_cards.find(value['id'])
      listed_card.amount = value['amount'].to_i
      listed_card.save
    end
  end
  redirect_to user_path(current_user)
end

def destroy
end

def binderlocation
end

def add_to_tradeable
  if current_user.check_for_tradeable_card(params[:card_id])
    current_user.tradeable_list.listed_cards.find_by(card_id: params[:card_id]).add(1)
  else
    new_card = current_user.tradeable_list.listed_cards.build(card_id: params[:card_id])
    new_card.list = current_user.tradeable_list
    new_card.save
  end

  redirect_to "/users/#{current_user.id}"
end

def add_to_wanted
  if current_user.check_for_wanted_card(params[:card_id])
    current_user.wanted_list.listed_cards.find_by(card_id: params[:card_id]).add(1)
  else
    new_card = current_user.wanted_list.listed_cards.build(card_id: params[:card_id])
    new_card.list = current_user.wanted_list
    new_card.save
  end

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

def from_list
  @user = current_user
  @list = List.find(params[:list_id])
  @list_partial = @list.name
  respond_to do |format|
    format.js
  end
end

def whereami
  # current_user.update_attributes(:latitude => params[:lato], :longitude => params[:longo] )

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

  def tradeable_params
    if params[:user][:tradeable_list_attributes]
      params[:user][:tradeable_list_attributes][:listed_cards_attributes]
    end
  end

  def wanted_params
    if params[:user][:wanted_list_attributes]
      params[:user][:wanted_list_attributes][:listed_cards_attributes]
    end
  end

end