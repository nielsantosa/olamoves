class PurchasesController < ApplicationController
  def create
    orders = params[:orders]

    total_price = 0
    orders.each do |order|
      total_price += order.video.price_cents
    end

    purchase  = Purchase.create!(total_price_cents: total_price, user: current_user, state: 'pending')

    session = Stripe::Checkout::Session.create(
      payment_method_types: ['card'],
      line_items: [{
        name: teddy.sku,
        images: [teddy.photo_url],
        amount: teddy.price_cents,
        currency: 'eur',
        quantity: 1
      }],
      success_url: order_url(order),
      cancel_url: order_url(order)
      )

    order.update(checkout_session_id: session.id)
    redirect_to new_order_payment_path(order)
  end
end
