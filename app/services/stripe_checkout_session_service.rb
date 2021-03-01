class StripeCheckoutSessionService
  def call(event)
    puts event.type
    puts event.data.object
    puts event.data.object.id
    purchase = Purchase.find_by(checkout_session_id: event.data.object.id)
    puts purchase
    purchase.update!(state: 'paid')
    puts purchase.state
  end
end
