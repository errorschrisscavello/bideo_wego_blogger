class Admin::TemplateLayoutsController < AdminController
  before_action :set_template_layout, :except => [:index, :new, :create]


  def index
    @template_layouts = TemplateLayout.all
  end


  def show
  end


  def new
    @template_layout = TemplateLayout.new
    @template_layout.build_data_file(:file_type_id => FileType.where(:extension => 'html.liquid').first.id)
  end


  def edit
  end


  def create
    @template_layout = TemplateLayout.new(template_layout_params)
    if @template_layout.save
      flash[:success] = 'Template Layout created'
      redirect_to admin_template_layout_path(@template_layout)
    else
      flash[:error] = 'Template Layout not created'
      render :new
    end
  end


  def update
    if @template_layout.update(template_layout_params)
      flash[:success] = 'Template Layout updated'
      redirect_to admin_template_layout_path(@template_layout)
    else
      flash[:error] = 'Template Layout not updated'
      render :edit
    end
  end


  def destroy
    if @template_layout.destroy
      flash[:success] = 'Template Layout destroyed'
    else
      flash[:error] = 'Template Layout not destroyed'
    end
    redirect_to admin_template_layouts_path
  end




  private
  def set_template_layout
    @template_layout = TemplateLayout.find_by_id(params[:id])
    redirect_to :back, :flash => { :error => 'TemplateLayout not found' } unless @template_layout
  end


  def template_layout_params
    params.require(:template_layout).permit(
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
