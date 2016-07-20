class User < ActiveRecord::Base
  VALID_USERNAME_REGEX = /\A[\w+\-.]+\z/i
  validates :username, presence: true, length: { maximum: 255 },
                    format: { with: VALID_USERNAME_REGEX },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }
end
