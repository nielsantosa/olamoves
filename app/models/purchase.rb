class Purchase < ApplicationRecord
  has_many :orders

  monetize :total_price_cents
end
