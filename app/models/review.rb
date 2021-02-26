class Review < ApplicationRecord
  belongs_to :video
  belongs_to :user
  validates :comment, presence: true
  validates :rating, length: { in: 1..5 }
end
