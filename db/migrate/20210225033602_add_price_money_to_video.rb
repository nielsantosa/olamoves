class AddPriceMoneyToVideo < ActiveRecord::Migration[6.0]
  def change
    add_monetize :videos, :price, currency: { present: false }
  end
end
