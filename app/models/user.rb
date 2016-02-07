class User < ActiveRecord::Base
  include UniquelyIdentifiable


  unique_id_seed :email
  unique_id_attribute :auth_token


  has_secure_password

  validates :email,
            :presence => true,
            :uniqueness => true,
            :format => { :with => /@/ }

  validates :username,
            :presence => true,
            :length => { :in => 8..32 },
            :format => { :with => /\A[\w\d]+\z/ }

  validates :password,
            :length => { :in => 8..32 },
            :format => { :without => /\s/ },
            :allow_nil => true


  before_destroy :deny_destroy_if_last


  def self.find_by_username_or_email(username_or_email)
    User.where(
      'email = ? OR username = ?',
      username_or_email,
      username_or_email
    ).first
  end




  private
  def deny_destroy_if_last
    is_last = User.count == 1
    if is_last
      errors.add(:base, 'Cannot destroy last user')
    end
    !is_last
  end
end

