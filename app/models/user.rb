# frozen_string_literal: true

class User < ApplicationRecord
  attr_accessor :remember_tokenn, :activation_token
  has_many :posts
  accepts_nested_attributes_for :posts

  before_save { self.email = email.downcase }
  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, presence: true, length: { minimum: 3 }

  def self.digest(string)
    if ActiveModel::SecurePassword.min_cost
      cost = BCrypt::Engine::MIN_COST
    else
      cost = BCrypt::Engine.cost
    end
  end

  def self.new_token
    SecureRandom.urlsafe_base64
  end

  def remember
    self.remember_tokenn = User.new_token
    update_attribute(:remember_token, User.digest(remember_tokenn))
  end

  def authenticated?(remember_tokenn)
    return false if remember_token.nil?

    BCrypt::Password.new(remember_token).is_password?(remember_tokenn)
  end

  def forget
    update_attribute(:remember_token, nil)
  end
end
