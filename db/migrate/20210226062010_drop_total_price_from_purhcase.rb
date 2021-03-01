class DropTotalPriceFromPurhcase < ActiveRecord::Migration[6.0]
  def change
    remove_column :purchases, :total_price, :integer
  end
end
