class PagesController < ApplicationController
  before_action :set_page, :except => [:index, :new, :create]


  def index
    @pages = Page.all
  end


  def show
  end


  def new
    @page = Page.new
    @page.build_slug
    @page.build_view
    @page.view.build_template
  end


  def edit
  end


  def create
    @page = Page.new(page_params)
    if @page.save
      flash[:success] = 'Page created'
      redirect_to @page
    else
      flash[:error] = 'Page not created'
      render :new
    end
  end


  def update
    if @page.update(page_params)
      flash[:success] = 'Page updated'
      redirect_to @page
    else
      flash[:error] = 'Page not updated'
      render :edit
    end
  end


  def destroy
    if @page.destroy
      flash[:success] = 'Page destroyed'
    else
      flash[:error] = 'Page not destroyed'
    end
    redirect_to pages_path
  end




  private
  def set_page
    @page = Page.find_by_id(params[:id])
    redirect_to :back, :flash => { :error => 'Page not found' } unless @page
  end


  def page_params
    params.require(:page).permit(
      :title,
      :parent_id,
      :view_id,
      :slug_id,
      :slug_attributes => [
        :id,
        :uri,
        :sluggable_type,
        :sluggable_id
      ],
      :view_attributes => [
        :id,
        :viewable_type,
        :viewable_id,
        :template_layout_id,
        :template_attributes => [
          :id,
          :body,
          :templateable_type,
          :templateable_id,
          :template_file_type_id
        ]
      ]
    )
  end
end
