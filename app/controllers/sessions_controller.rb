class SessionsController < ApplicationController
  
  def new    
  end

  def create
<<<<<<< HEAD
    @user = login(params[:email], params[:password], params[:remember_me])
    if @user
      redirect_back_or_to root_url, :notice => "Logged in!"
=======
    user = login(params[:email], params[:password])
      if user
        redirect_back_or_to root_url, :notice => "Logged in!"
>>>>>>> d74e72a2506ab6b39df588b0462c30b0fbcea94d
    else
      flash.now.alert = "Email or password was invalid"
      render :new
    end
  end

  def destroy
    logout
    redirect_to root_url, :notice => "Logged out!"
  end

end
