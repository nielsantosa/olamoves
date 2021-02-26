class PurchasesController < ApplicationController

  def index
    @purchases = Purchase.where(user: current_user)
  end

  def create
    orders = current_user.orders.where(confirmed: false)

    total_price = 0
    orders.each do |order|
      total_price += order.video.price_cents
    end

    purchase = Purchase.create!(total_price_cents: total_price, user: current_user, state: 'pending')

    purchase.orders.concat(orders)

    serialized_orders = serialize(orders)

    session = Stripe::Checkout::Session.create(
      payment_method_types: ['card'],
      line_items: serialized_orders,
      success_url: purchase_payments_success_url(purchase),
      cancel_url: purchase_payments_cancel_url(purchase)
      )

    purchase.update(checkout_session_id: session.id)
    redirect_to new_purchase_payment_path(purchase)
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

  private

  def serialize(orders)
    new_array = []
    orders.each_with_object(new_array) do |order, new_array|
      new_array.push({
          name: order.video.title,
          amount: order.video.price_cents,
          currency: 'sgd',
          quantity: 1
    })
    end
  end
end
