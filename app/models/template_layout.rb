class TemplateLayout < ActiveRecord::Base
  has_one :data_file, :as => :data_fileable, :dependent => :destroy
  has_many :views, :dependent => :nullify

  accepts_nested_attributes_for :data_file
end
