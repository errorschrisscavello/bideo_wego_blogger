class View < ActiveRecord::Base
  belongs_to :viewable, :polymorphic => true
  belongs_to :template_layout
  has_one :data_file, :as => :data_fileable

  accepts_nested_attributes_for :data_file
end
