class PaymentsController < ApplicationController
  def new
    @purchase = current_user.purchases.where(state: 'pending').find(params[:purchase_id])
  end

  def success
    @purchase = current_user.purchases.find(params[:purchase_id])

    if @purchase.state == "paid"
      @purchase.orders.each do |order|
        order.confirmed = true
        order.save
      end
    end
  end

  def cancel
    @purchase = current_user.purchases.find(params[:purchase_id])
  end
end
