class SessionsController < ApplicationController
  before_action :require_logout, :only => [:create]

  def new
  end


  def create
    @user = User.find_by_username_or_email(params[:username_or_email])
    p @user
    if @user && @user.authenticate(params[:password])
      if sign_in(@user)
        flash[:success] = 'You are now signed in'
      else
        flash[:success] = 'There was a problem signing you in'
      end
    else
      flash[:error] = 'Unable to sign in'
    end
    redirect_to root_path
  end


  def destroy
    if current_user && sign_out
      flash[:success] = 'You are now signed out'
    else
      flash[:error] = 'Unable to sign out'
    end
    redirect_to root_path
  end
end
