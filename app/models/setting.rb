class Setting < ActiveRecord::Base
  belongs_to :setting_type

  # TODO add validations
end
