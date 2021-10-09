class Task < ApplicationRecord
  belongs_to :category

  validates :name, presence: true
  # add maximum length validation for name & description
end
