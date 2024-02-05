class Deal < ApplicationRecord
    belongs_to :user, foreign_key: 'author_id'
    has_and_belongs_to_many :categories
    validates :name, :amount, presence: true
    validates :amount, numericality: { greater_than_or_equal_to: 0 }
  end
  