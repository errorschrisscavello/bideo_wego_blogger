class Page < ActiveRecord::Base
  include UniquelyIdentifiable


  unique_id_seed :title
  unique_id_attribute :uid


  belongs_to :parent, :class_name => 'Page'
  has_one :slug, :as => :sluggable, :dependent => :destroy
  has_one :view, :as => :viewable, :dependent => :destroy


  validates :title,
            :presence => true,
            :uniqueness => true

  validates :view,
            :presence => true,
            :on => :update

  validates :slug,
            :presence => true,
            :on => :update

  validate :parent_cannot_be_self


  accepts_nested_attributes_for :slug
  accepts_nested_attributes_for :view




  private
  def parent_cannot_be_self
    if parent == self
      errors.add(:parent, 'A page cannot have itself as a parent')
    end
  end
end
