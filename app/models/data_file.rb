class DataFile < ActiveRecord::Base
  belongs_to :file_type
  belongs_to :data_fileable, :polymorphic => true


  def partials
    partial_names = body.scan(/\{% partial .?(\w+).?/).flatten
    Partial.where('name IN [?]', partial_names)
  end
end
