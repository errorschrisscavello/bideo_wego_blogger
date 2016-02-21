class TemplateLayout < ActiveRecord::Base
  has_one :template, :as => :templateable
  has_many :views

  accepts_nested_attributes_for :template
end
