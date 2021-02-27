class Goal < ApplicationRecord
  belongs_to :user
  validates :description, presence: true
  validates :comment, length: { maximum: 30 }
end
