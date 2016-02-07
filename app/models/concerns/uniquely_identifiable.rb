module UniquelyIdentifiable
  extend ActiveSupport::Concern


  included do
    before_create :assign_unique_id
  end


  def refresh_unique_id
    assign_unique_id
  end


  class_methods do
    @@unique_id_seed = nil
    @@unique_id_attribute = :uid


    def unique_id_seed(value=nil)
      @@unique_id_seed = value unless value.nil?
      @@unique_id_seed
    end


    def unique_id_attribute(name=nil)
      @@unique_id_attribute = name unless name.nil?
      @@unique_id_attribute
    end


    def generate_unique_id(seed)
      t = Time.now
      SecureRandom.uuid + '-' +
        Digest::MD5.new.hexdigest(seed) + '-' +
        t.to_i.to_s + '-' +
        t.usec.to_s
    end
  end




  private
  def assign_unique_id
    seed_method = self.class.unique_id_seed
    seed = self.send(seed_method)
    unique_id = self.class.generate_unique_id(seed)
    attribute_method = "#{self.class.unique_id_attribute}=".to_sym
    self.send(attribute_method, unique_id)
  end
end

