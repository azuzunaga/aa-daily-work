# t.string "email", null: false
# t.string "session_token", null: false
# t.string "password_digest", null: false
# t.datetime "created_at", null: false
# t.datetime "updated_at", null: false
# t.index ["email"], name: "index_users_on_email", unique: true
# t.index ["session_token"], name: "index_users_on_session_token", unique: true

class User < ApplicationRecord
  validates :email, presence: true, uniqueness: true
  validates :password, length: { minimum: 6, allow_nil: true }
  validates :password_digest, presence: true
  validates :session_token, presence: true, uniqueness: true

  after_initialize :ensure_session_token

  attr_reader :password

  def self.generate_session_token
    SecureRandom::urlsafe_base64
  end

  def reset_session_token!
    self.session_token = User.generate_session_token
    self.save
    self.session_token
  end

  def ensure_session_token
    self.session_token ||= User.generate_session_token
  end

  def password=(password)
    @password = BCrypt::Password.create(password)
    self.password_digest = @password
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  def self.find_by_credentials(email, password)
    user = User.find_by(email: email)

    return user if user && user.is_password?(password)

    nil
  end
end
