class Category < ApplicationRecord
    has_many :tasks, dependent: :destroy

    validates :title, presence: true
    # add max length
end
