class SlugsController < ApplicationController
  def index
    @slugs = Slug.all
  end
end
