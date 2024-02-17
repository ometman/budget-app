class Category < ApplicationRecord
  include IconUploader::Attachment(:icon)

  belongs_to :user, dependent: :destroy
  has_many :deals

  validates :name, presence: true, length: { maximum: 250 }

  default_scope { order(name: :asc) }
end
