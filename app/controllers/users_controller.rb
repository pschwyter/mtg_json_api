class UsersController < ApplicationController

def new
  @user = User.new
end

def create
    @user = User.new(user_params)
    if @user.save
      auto_login(@user)
      redirect_to new_user_url, notice: "Signed up!"
    else
      render "new"
    end
end

def index
  @users = User.where("id != ?", current_user.id)
  @unaccepted_trades_count = current_user.unaccepted_trades_count
  gon.cardsets_users = CardSet.all.map {|set| set.name }
end

def show
  # gon.cardnames = Card.limit(10).pluck(:name)
  # gon.cardsets = Card.limit(10).map {|card| card.card_set.name }
  @unaccepted_trades_count = current_user.unaccepted_trades_count
  @user = User.find(params[:id])
  c_position = [current_user.latitude, current_user.longitude]
  @current_position = User.near(c_position, 10, units: :km)
  # @distance = current_user.distance_between(current_user, User.all) 
end

def edit
  @user = User.find(params[:id])
  @unaccepted_trades_count = current_user.unaccepted_trades_count
end

def update
  @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
end

def update_lists
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
  elsif inventory_params
    inventory_params.each do |key, value| 
      listed_card = @user.inventory_cards.find(value['id'])
      listed_card.amount = value['amount'].to_i
      listed_card.save
    end
  end
  redirect_to user_path(current_user)
end

def destroy
end

def add_to_tradeable
  if current_user.check_for_tradeable_card(params[:card_id])
    current_user.tradeable_list.listed_cards.find_by(card_id: params[:card_id]).add(1)
  else
    new_card = current_user.tradeable_list.listed_cards.build(card_id: params[:card_id])
    new_card.list = current_user.tradeable_list
    new_card.save
  end
  # redirect_to "/users/#{current_user.id}"
end

def add_to_wanted
  if current_user.check_for_wanted_card(params[:card_id])
    current_user.wanted_list.listed_cards.find_by(card_id: params[:card_id]).add(1)
  else
    new_card = current_user.wanted_list.listed_cards.build(card_id: params[:card_id])
    new_card.list = current_user.wanted_list
    new_card.save
  end
  # redirect_to "/users/#{current_user.id}"
end

def add_to_inventory
  if current_user.check_for_inventory_card(params[:card_id])
    current_user.inventory_list.listed_cards.find_by(card_id: params[:card_id]).add(1)
  else
    new_card = current_user.inventory_list.listed_cards.build(card_id: params[:card_id])
    new_card.list = current_user.inventory_list
    new_card.save
  end
  # redirect_to "/users/#{current_user.id}"
end

def from_list
  @user = User.find(params[:user_id])
  @list = List.find(params[:list_id])
  @list_partial = @list.name
  respond_to do |format|
    format.js
  end
end

def from_inventory
  @user = User.find(params[:id])
  respond_to do |format|
    format.js
  end
end

def update_nav_bar_unaccepted_trades_count
  # @user = current_user
  @unaccepted_trades_count = current_user.unaccepted_trades_count

  respond_to do |format|
    format.js
  end
end

def whereami

  current_user.assign_attributes(:latitude => params[:lato], :longitude => params[:longo] )
  position_hash = current_user.changed_attributes
  if position_hash["latitude"] != nil && position_hash["longitude"] != nil
    if position_hash["longitude"].round(3) === current_user.longitude.round(3) && position_hash["latitude"].round(3) === current_user.latitude.round(3)
    else
      current_user.save
    end
  else
    current_user.save
  end
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

  def inventory_params
    if params[:user][:inventory_list_attributes]
      params[:user][:inventory_list_attributes][:listed_cards_attributes]
    end
  end

end