class UsersController < ApplicationController

def new
	@user = User.new
end

def create
    @user = User.new(user_params)
    if @user.save
      redirect_to users_url, notice: "Signed up!"
    else
      render "new"
    end
end

def show
end

def edit
end

def update
end

def destroy
end

private
  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end


end
