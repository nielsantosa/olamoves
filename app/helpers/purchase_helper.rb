module PurchaseHelper
  def create_session(opt = { purchase: nil })
    purchase = opt[:purchase]

    orders = purchase.orders

    serialized_orders = serialize(orders)

    session = Stripe::Checkout::Session.create(
      payment_method_types: ['card'],
      line_items: serialized_orders,
      success_url: purchase_payments_success_url(purchase),
      cancel_url: purchase_payments_cancel_url(purchase))
    purchase.update(checkout_session_id: session.id)
    purchase.update!(state: 'pending')
  end

  private

  def serialize(orders)
    new_array = []
    orders.each_with_object(new_array) do |order, new_array|
      new_array.push(
        {
          name: order.video.title,
          amount: order.video.price_cents,
          currency: 'sgd',
          quantity: 1
        }
      )
    end
  end
end
