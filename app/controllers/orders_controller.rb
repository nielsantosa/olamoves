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

  def create
    video_id = params.require(:video).require(:video)
    video = Video.find(video_id)
    order = Order.new(user: current_user, confirmed: false)
    order.video = video
    if order.save
      redirect_to cart_path
      flash.alert = "Successfully added to cart"
    else
      redirect_to video_path(video)
      flash.alert = "You have owned/added this video already"
    end
  end

  def destroy
    order = Order.find(params[:id])
    order.destroy
    redirect_to cart_path
  end

  def confirm
    @user = current_user
    @purchased_orders = Order.where(user: @user, confirmed: false)
    @purchased_orders.each do |order|
      order.confirmed = true
      order.save!
    end

    redirect_to myprofile_path
    flash.alert = "Successfully bought the videos"
  end
end

