class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 250 }
  validates :email, presence: true, uniqueness: true, format: { with: /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/ }
  validates :password, presence: true, length: { minimum: 6, maximum: 30 }

  has_many :categories, dependent: :destroy
  has_many :deals, foreign_key: :author_id, dependent: :destroy, through: :categories
end
