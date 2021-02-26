class PurchasesController < ApplicationController
  def create
    orders = current_user.orders

    total_price = 0
    orders.each do |order|
      total_price += order.video.price_cents
    end

    purchase  = Purchase.create!(total_price_cents: total_price, user: current_user, state: 'pending')

    purchase.orders.concat(orders)

    serialized_orders = serialize(orders)

    session = Stripe::Checkout::Session.create(
      payment_method_types: ['card'],
      line_items: serialized_orders,
      success_url: root_url,
      cancel_url: purchase_url(purchase)
      )

    purchase.update(checkout_session_id: session.id)
    redirect_to new_purchase_payment_path(purchase)
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
