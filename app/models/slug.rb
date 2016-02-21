class Slug < ActiveRecord::Base
  belongs_to :sluggable, :polymorphic => true

  validates :uri,
            :presence => true,
            :uniqueness => true
end
