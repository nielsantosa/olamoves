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
    raise
    # check if current_user.order.video == @video
    # check if current_user.order.confirmed == true
    # if both pass, then savecurrent_

    if @review.save
      @current_review = @review
      redirect_to video_path(@video)
    else
      render :new
    end
  end

  def destroy
    @review = Review.find(params[:id])
    @review.destroy
    redirect_to video_path(@review.video)
  end

  private

  def review_params
    params.require(:review).permit(:comment, :rating)
  end
end
