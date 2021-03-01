class AddColumnsToPurchases < ActiveRecord::Migration[6.0]
  def change
    add_monetize :purchases, :total_price, currency: { present: false }
    add_reference :purchases, :user, foreign_key: true
    add_column :purchases, :checkout_session_id, :string
    add_column :purchases, :state, :string
  end
end
