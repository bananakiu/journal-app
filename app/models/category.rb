class Category < ApplicationRecord
    belongs_to :user
    has_many :tasks, dependent: :destroy

    validates :title, presence: true, length: { maximum: 20 }
    validates :title, uniqueness: true
end