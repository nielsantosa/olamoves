class OrdersController < ApplicationController
  def checkout
    @user = current_user
    @purchased_order = Order.where(user: @user, confirmed: false)
    @purchased_videos = @purchased_order.map do |order|
      order.video
    end

    @total_price = 0
    @purchased_videos.each do |video|
      @total_price += video.price
    end
  end
end
