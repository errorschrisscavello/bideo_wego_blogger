class Admin::PartialsController < AdminController
  before_action :set_partial, :except => [:index, :new, :create]


  def index
    @partials = Partial.all
  end


  def show
  end


  def new
    @partial = Partial.new
    @partial.build_data_file
  end


  def edit
  end


  def create
    @partial = Partial.new(partial_params)
    if @partial.save
      flash[:success] = 'Partial created'
      redirect_to admin_partial_path(@partial)
    else
      flash[:error] = 'Partial not created'
      render :new
    end
  end


  def update
    if @partial.update(partial_params)
      flash[:success] = 'Partial updated'
      redirect_to admin_partial_path(@partial)
    else
      flash[:error] = 'Partial not updated'
      render :edit
    end
  end


  def destroy
    if @partial.destroy
      flash[:success] = 'Partial destroyed'
    else
      flash[:error] = 'Partial not destroyed'
    end
    redirect_to admin_partials_path
  end




  private
  def set_partial
    @partial = Partial.find_by_id(params[:id])
    redirect_to :back, :flash => { :error => 'Partial not found' } unless @partial
  end


  def partial_params
    params.require(:partial).permit(
      :name,
      :data_file_attributes => [
        :id,
        :body,
        :data_fileable_type,
        :data_fileable_id,
        :file_type_id
      ]
    )
  end
end
