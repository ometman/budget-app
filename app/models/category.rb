class Category < ApplicationRecord
  belongs_to :user, dependent: :destroy
  has_many :deals
  validates :name, presence: true, length: { maximum: 250 }
  has_one_attached :icon

  default_scope { order(name: :asc) }
  scope :most_recent, -> { order(created_at: :desc).limit(3) }
  scope :oldest, -> { order(created_at: :asc).limit(3) }
end
