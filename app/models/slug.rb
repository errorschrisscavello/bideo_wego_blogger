class Slug < ActiveRecord::Base
  belongs_to :sluggable, :polymorphic => true

  validates :uri,
            :presence => true,
            :uniqueness => true

  validates :sluggable_id,
            :presence => true,
            :uniqueness => { :scope => :sluggable_type }

  validates :sluggable_type,
            :presence => true,
            :uniqueness => { :scope => :sluggable_id }
end
