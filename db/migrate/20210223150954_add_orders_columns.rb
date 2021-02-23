class AddOrdersColumns < ActiveRecord::Migration[6.0]
  def change
    add_reference :orders, :video, foreign_key: true
    add_reference :orders, :user, foreign_key: true
    add_reference :orders, :purchase, foreign_key: true
    add_column :orders, :confirmed, :boolean, default: false
  end
end
