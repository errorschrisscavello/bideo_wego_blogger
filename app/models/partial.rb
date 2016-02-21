class Partial < ActiveRecord::Base
  has_one :template, :as => :templateable

  accepts_nested_attributes_for :template
end
