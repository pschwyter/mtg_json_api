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
  @user = current_user
  @user.tradeable_cards << Card.find(params[:card_id])
  redirect_to "/users/#{current_user.id}"
end

def destroy
end

private
  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :dci_number, :password, :password_confirmation)
  end


end
