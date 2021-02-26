class Purchase < ApplicationRecord
  has_many :orders
  belongs_to :user

  monetize :total_price_cents
end
