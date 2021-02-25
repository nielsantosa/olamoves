class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home

  def home
    @videos = Video.all.sort_by(&:created_at).reverse
    @videos_one = @videos[0]
    @videos_two = @videos[1]
    @videos_three = @videos[2]
    @videos_four = @videos[3]
    @videos_five = @videos[4]
    @videos_six = @videos[5]
    @videos_seven = @videos[6]
    @videos_eight = @videos[7]
    @videos_nine = @videos[8]

    # @pop_vid = Video.where("price > 100").order(:price).reverse_order
  end

  def myprofile
    @user = current_user
    @purchased_order = Order.where(user: @user, confirmed: true)
    @purchased_videos = @purchased_order.map do |order|
      order.video
    end
  end
end
