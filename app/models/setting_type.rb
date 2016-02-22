class SettingType < ActiveRecord::Base
  has_many :settings, :dependent => :nullify

  # TODO add validations
  # TODO validate uniqueness of [setting_type_id, key]

  accepts_nested_attributes_for :settings
end
