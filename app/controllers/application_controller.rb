class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception


  def current_user
    if User.where(:auth_token => session[:auth_token])
      unless @current_user && @current_user.auth_token == session[:auth_token]
        @current_user = User.find_by_auth_token(session[:auth_token])
      end
    end
  end
  helper_method :current_user


  def signed_in_user?
    !!current_user
  end
  helper_method :signed_in_user?


  def is_current_user?(user)
    user.id == current_user.id
  end
  helper_method :is_current_user?




  protected
  def sign_in(user)
    session[:auth_token] = user.create_auth_token
    @current_user = user
    @current_user == user && session[:auth_token] == user.auth_token
  end


  def sign_out
    @current_user = session[:auth_token] = nil
    @current_user.nil? && session[:auth_token].nil?
  end


  def require_login
    unless signed_in_user? && request.path == root_path
      flash[:error] = 'That action requires you to be logged in'
    end
    redirect_to root_path
  end


  def require_logout
    if signed_in_user?
      flash[:error] = 'Logout first!'
      redirect_to root_path
    end
  end


  def require_current_user
    user_id = controller_name == 'users' ? params[:id] : params[:user_id]
    unless current_user && user_id.to_i == current_user.id.to_i
      flash[:error] = 'You are unauthorized to perform that action'
    end
  end
end

