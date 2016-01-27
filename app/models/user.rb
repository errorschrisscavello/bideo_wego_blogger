class User < ActiveRecord::Base
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


  after_create :create_auth_token
  before_destroy :deny_destroy_if_last


  def create_auth_token
    update!(:auth_token => generate_auth_token)
    auth_token
  end


  def self.find_by_username_or_email(username_or_email)
    User.where(
      'email = ? OR username = ?',
      username_or_email,
      username_or_email
    ).first
  end




  private
  def generate_auth_token
    str = SecureRandom.uuid + email
    SecureRandom.urlsafe_base64 + Base64.urlsafe_encode64(str)
  end


  def deny_destroy_if_last
    is_last = User.count == 1
    if is_last
      errors.add(:base, 'Cannot destroy last user')
    end
    !is_last
  end
end

