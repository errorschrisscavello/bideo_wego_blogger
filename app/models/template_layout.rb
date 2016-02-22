class TemplateLayout < ActiveRecord::Base
  has_one :data_file, :as => :data_fileable
  has_many :views

  accepts_nested_attributes_for :data_file
end
