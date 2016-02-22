class SlugsController < ApplicationController
  before_action :set_slug


  def show
    @data = {}
    Setting.all.to_a.each { |setting| @data[setting.key] = setting.value }
  end





  private
  def set_slug
    @slug = Slug.find_by_uri(params[:slug])
    redirect_to not_found_path unless @slug
  end
end
