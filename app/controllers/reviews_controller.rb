class ReviewsController < ApplicationController
  def new
    @video = Video.find(params[:video_id])
    @review = Review.new
  end

  def create
    @review = Review.new(review_params)
    @video = Video.find(params[:video_id])
    @review.video = @video
    @review.user = current_user
    if @review.save
      redirect_to video_path(@video)
    else
      render :new
    end
  end

  private

  def review_params
    params.require(:review).permit(:comment, :rating)
  end
end
