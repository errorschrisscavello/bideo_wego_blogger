class ErrorsController < ApplicationController
  before_action :set_code


  def show
    render @code, :status => @code
  end




  private
  def set_code
    p [params]
    @code = [404, 422, 500].include?(params[:code].to_i) ? params[:code] : 500
  end
end
