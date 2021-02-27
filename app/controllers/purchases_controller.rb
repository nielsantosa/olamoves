class PurchasesController < ApplicationController
  def index
    @purchases = Purchase.where(user: current_user)
  end

  def create
    # Clean all purchases that is pending
    @purchases = current_user.purchases.where(state: 'unsend')
    @purchases.each do |purchase|
      purchase.orders.each do |order|
        order.purchase = nil
        order.save
      end
      purchase.destroy
    end

    orders = current_user.orders.where(confirmed: false)

    total_price = 0
    orders.each do |order|
      total_price += order.video.price_cents
    end

    @purchase = Purchase.create!(total_price_cents: total_price, user: current_user, state: 'unsend')

    # Make the orders to have purchase = purchase
    @purchase.orders.concat(orders)

    redirect_to new_purchase_payment_path(@purchase)
  end

  def destroy
    purchase = current_user.purchases.find(params[:id])
    purchase.orders.each do |order|
      order.purchase = nil
      order.save
    end

    purchase.destroy

    redirect_to cart_path
  end
end
