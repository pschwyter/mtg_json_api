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

def destroy
end

def whereami
  coords = [params[:lato],params[:longo]]

  if current_user.location_history
    current_user.location_history << coords
  else
    current_user.location_history = coords
  end
end

private
  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :dci_number, :password, :password_confirmation)
  end


end
