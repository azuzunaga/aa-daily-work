class User < ApplicationRecord
  validates :user_name, presence: true, uniqueness: true
  validates :password_digest, presence: { message: 'Password can\'t be blank'}
  validates :password, length: { minimum: 6, allow_nil: true }
  validates :session_token, presence: true, uniqueness: true

  attr_reader :password

  def self.find_by_credentials(user_params)
    user = User.find_by(user_name: user_params[:user_name])
    return user if user && user.is_password?(user_params[:password])
    nil
  end

  def reset_session_token!
    self.session_token = User.generate_new_session_token
  end

  def self.generate_new_session_token
    SecureRandom::urlsafe_base64
  end

  def password=(password)
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end
end
