class View < ActiveRecord::Base
  belongs_to :viewable, :polymorphic => true
  belongs_to :template_layout
  has_one :template, :as => :templateable

  accepts_nested_attributes_for :template
end
