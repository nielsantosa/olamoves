class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home

  def home
  end

  def myprofile
    @user = current_user
    @purchased_order = Order.where(user: @user, confirmed: true)
    @purchased_videos = @purchased_order.map do |order|
      order.video
    end
  end
end
