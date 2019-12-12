class User < ApplicationRecord
  before_destroy :last_user
  has_many :tasks, dependent: :destroy
  has_many :labels, dependent: :destroy
  before_validation { email.downcase! }

  has_secure_password
  validates :password, presence: true, length: { minimum: 4 }, on: :create
  validates :password, length: {minimum: 4}, on: :update, allow_blank: true

  validates :email, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/ }
  
  def last_user
    count = User.count
    if count == 1
    throw :abort
    end
  end
end
