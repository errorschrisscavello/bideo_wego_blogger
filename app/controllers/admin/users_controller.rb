class Admin::UsersController < AdminController
  before_action :require_current_user, :only => [:edit, :update, :destroy]
  before_action :set_user, :only => [:show, :edit, :update, :destroy]


  def index
    @users = User.all
  end


  def show
  end


  def new
    @user = User.new
  end


  def edit
  end


  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to admin_user_path(@user), :flash => { :success => 'User created' }
    else
      flash.now[:error] = 'User not created'
      render :new
    end
  end


  def update
    if @user.update(user_params)
      redirect_to admin_user_path(@user), :flash => { :success => 'User updated' }
    else
      flash.now[:error] = 'User not updated'
      render :edit
    end
  end


  def destroy
    # TODO a user should not be signed out if it is the last user and destroy is attempted
    sign_out_if_current_user
    if @user.destroy
      flash[:success] = 'User destroyed'
    else
      flash[:error] = 'User not destroyed: ' +
        @user.errors.full_messages.join(', ')
    end
    redirect_to root_path
  end




  private
  def set_user
    if action_name == 'show'
      @user = User.find_by_id(params[:id])
    else
      @user = current_user
    end
    redirect_to root_path, :flash => { :error => 'Unable to find user' } unless @user
  end


  def user_params
    params.require(:user).permit(
      :email,
      :username,
      :password,
      :password_confirmation
    )
  end


  def sign_out_if_current_user
    if is_current_user?(@user)
      unless sign_out
        flash[:error] = 'Unable to sign out user'
        redirect_to admin_users_path
      end
    end
  end


  def require_current_user
    unless params[:id].to_i == current_user.id.to_i
      flash[:error] = 'You are unauthorized to perform that action'
      redirect_to root_path
    end
  end
end

