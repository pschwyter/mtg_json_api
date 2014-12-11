class SessionsController < ApplicationController
  
  def new
  end

  def create
  	user = User.find_by(email: params[:email])
  	if user && user.authenticate(params[:password])
  		session[:user_id] = user.id.to_s
  		redirect_to new_user_url, notice: "Logged in!"
  	else
  		flash.now[:alert] = "Invalid email or password"
  		render "new"
  	end
  end

  def destroy
  	session[:user_id] = nil
  	redirect_to new_user_url, notice: "Logged out!"
  end

end