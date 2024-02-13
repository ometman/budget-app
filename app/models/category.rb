class Category < ApplicationRecord
  belongs_to :user, dependent: :destroy
  has_many :deals
  
  validates :name, presence: true, length: { maximum: 250 }
  has_one_attached :icon

  default_scope { order(name: :asc) }
end
