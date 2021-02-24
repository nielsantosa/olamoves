class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home

  def home
  end

  def myprofile
    @user = current_user
    # user_order = @user.orders.confirmed?
    # @videos = user_order.
    @videos = @user.videos.where(Order.confirmed?)
  end
end
