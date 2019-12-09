class User < ApplicationRecord
  has_many :tasks
  before_validation { email.downcase! }

  has_secure_password
  validates :password, presence: true, length: { minimum: 4 }, on: :create
  validates :password, length: {minimum: 4}, on: :update, allow_blank: true

  validates :email, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/ }
end
