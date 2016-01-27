module ControllerHelper
  def login(user)
    session[:auth_token] = user.create_auth_token
  end


  def logout
    session[:auth_token] = nil
  end


  def current_user
    if User.exists?(session[:auth_token]) && session[:auth_token]
      User.find(session[:auth_token])
    end
  end


  def signed_in_user?
    !!current_user
  end
end

