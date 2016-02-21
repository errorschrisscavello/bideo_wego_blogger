class Template < ActiveRecord::Base
  belongs_to :template_file_type
  belongs_to :templateable, :polymorphic => true
end
