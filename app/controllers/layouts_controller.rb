class LayoutsController < ApplicationController
  before_action :set_layout, :except => [:index, :new, :create]


  def index
    @layouts = Layout.all
  end


  def show
  end


  def new
    @layout = Layout.new
  end


  def edit
  end


  def create
    @layout = Layout.new(layout_params)
    if @layout.save
      flash[:success] = 'Layout created'
      redirect_to @layout
    else
      flash[:error] = 'Layout not created'
      render :new
    end
  end


  def update
    if @layout.update(layout_params)
      flash[:success] = 'Layout updated'
      redirect_to @layout
    else
      flash[:error] = 'Layout not updated'
      render :edit
    end
  end


  def destroy
    if @layout.destroy
      flash[:success] = 'Layout destroyed'
    else
      flash[:error] = 'Layout not destroyed'
    end
    redirect_to layouts_path
  end




  private
  def set_layout
    @layout = Layout.find_by_id(params[:id])
    redirect_to :back, :flash => { :error => 'Layout not found' } unless @layout
  end


  def layout_params
    params.require(:layout).permit(
      :name
    )
  end
end
