class SessionsController < ApplicationController
  def new
    render :new
  end

  def create
    @user = user = User.find_by_credentials(
      params[:user][:username],
      params[:user][:password]
    )
    if user.nil?
      @user.errors.full_messages << "Incorrect credentials"
      flash.now[:errors] = @user.errors.full_messages
      render :new
    else
      login_user!
    end
  end

  def destroy
    current_user.reset_session_token!
    session[:session_token] = nil
    redirect_to new_session_url
  end
end
