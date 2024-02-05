class Category < ApplicationRecord
  belongs_to :user
  has_many :deals
  validates :name, presence: true, length: { maximum: 250 }
  has_one_attached :icon
end

