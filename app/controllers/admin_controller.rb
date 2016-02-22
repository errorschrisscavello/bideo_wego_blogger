class AdminController < ApplicationController
  before_action :require_login


  layout 'admin'


  def index
  end
end
