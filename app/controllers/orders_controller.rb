class OrdersController < ApplicationController
  def checkout
    @user = current_user
    @purchased_orders = Order.where(user: @user, confirmed: false)
    @purchased_videos = @purchased_orders.map do |order|
      order.video
    end

    @total_price = 0
    @purchased_videos.each do |video|
      @total_price += video.price
    end
  end

  def destroy
    order = Order.find(params[:id])
    order.destroy

    redirect_to cart_path
  end
end
