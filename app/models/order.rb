class Order < ApplicationRecord
  belongs_to :user
  belongs_to :video
  belongs_to :purchase

  validates :user, presence: true
  validates :video, presence: true
end
