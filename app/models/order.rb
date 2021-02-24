class Order < ApplicationRecord
  belongs_to :user
  belongs_to :video

  validates :user, presence: true
  validates :video, presence: true
  validates :user, uniqueness: { scope: [:video, :purchase] }

  scope :confirmed?, -> { where(confirmed: true) }
end
