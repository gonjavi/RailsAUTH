class User < ApplicationRecord
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
    validates :name, presence: {string: true}, length:{minimum: 2}
    validates :password, presence: true, length: { minimum: 3 }, allow_nil: true
    has_secure_password 
end
