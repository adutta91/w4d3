class User < ActiveRecord::Base
  after_initialize do |user|
    user.reset_session_token!
  end

  attr_reader :password

  before_validation do
        
  end

  validates :username, :password_digest, :session_token, presence: true
  validates :username, :session_token, uniqueness: true
  validates :password, length: {minimum: 6, allow_nil: true}

  def reset_session_token!
    self[:session_token] ||= SecureRandom.urlsafe_base64
  end

  def password=(password)
    @password = password
    self[:password_digest] = BCrypt::Password.create(password).to_s
  end

  def is_password?(password)
    BCrypt::Password.new(self[:password_digest]).is_password?(password)
  end

  def self.find_by_credentials(username, password)
    user = User.find_by(username: username)
    return nil if user.nil?
    return user if user.is_password?(password)
    nil
  end


  has_many :cats, :class_name => "Cat", :foreign_key => "user_id"

end
