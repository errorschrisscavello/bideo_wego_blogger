class Partial < ActiveRecord::Base
  has_one :data_file, :as => :data_fileable

  accepts_nested_attributes_for :data_file
end
