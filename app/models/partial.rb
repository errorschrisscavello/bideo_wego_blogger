class Partial < ActiveRecord::Base
  has_one :data_file, :as => :data_fileable, :dependent => :destroy

  accepts_nested_attributes_for :data_file

  def rendered_in
    DataFile.where(%Q;body LIKE '%\{\% partial _#{name}_%';)
  end
end
