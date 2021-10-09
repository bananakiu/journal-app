class Task < ApplicationRecord
  belongs_to :category

  validates :name, presence: true, length: { maximum: 100 }
  validates :notes, length: { maximum: 2000 }
end