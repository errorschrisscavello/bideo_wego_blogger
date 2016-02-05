class SettingTypesController < ApplicationController
  before_action :set_setting_type, :only => [:show, :edit, :update, :destroy]


  def index
    @setting_types = SettingType.all
  end


  def show
  end


  def new
    @setting_type = SettingType.new
  end


  def edit
  end


  def create
    @setting_type = SettingType.new(setting_type_params)
    if @setting_type.save
      redirect_to @setting_type, :flash => { :success => 'Setting type created' }
    else
      flash.now[:error] = 'Setting type not created'
      render :new
    end
  end


  def update
    if @setting_type.update(setting_type_params)
      redirect_to @setting_type, :flash => { :success => 'Setting type updated' }
    else
      flash.now[:error] = 'Setting type not updated'
      render :edit
    end
  end


  def destroy
    if @setting_type.destroy
      flash[:success] = 'Setting type destroyed'
    else
      flash[:error] = 'Setting type not destroyed: ' +
        @setting_type.errors.full_messages.join(', ')
    end
    redirect_to setting_types_path
  end




  private
  def set_setting_type
    @setting_type = SettingType.find_by_id(params[:id])
    redirect_to setting_types_path, :flash => { :error => 'Unable to find setting type ' } unless @setting_type
  end


  def setting_type_params
    params.require(:setting_type).permit(
      :name,
      :settings_attributes => [
        :id,
        :key,
        :value,
        :setting_type_id
      ]
    )
  end
end
