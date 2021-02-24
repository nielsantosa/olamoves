class Order < ApplicationRecord
  belongs_to :user
  belongs_to :video

  validates :user, presence: true
  validates :video, presence: true

  scope :confirmed?, -> { where(confirmed: true) }
end
