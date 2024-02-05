# User model
class User < ApplicationRecord
    has_many :categories
    has_many :deals, foreign_key: 'author_id'
    validates :name, presence: true, length: { maximum: 250 }
    validates :email, presence: true, uniqueness: true, format: { with: /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/ }
    validates :password, presence: true, length: { minimum: 6, maximum: 30 }
  end
  

  