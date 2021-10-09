class Category < ApplicationRecord
    has_many :tasks, dependent: :destroy

    validates :title, presence: true, length: { maximum: 30 }
end