class SlugsController < ApplicationController
  before_action :set_slug


  def show
  end





  private
  def set_slug
    @slug = Slug.find_by_uri(params[:slug])
    redirect_to not_found_path unless @slug
  end
end
