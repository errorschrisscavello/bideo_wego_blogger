class SlugsController < ApplicationController
  # TODO slug CRUD should be performed through it's sluggables

  def index
    @slugs = Slug.all
  end
end
