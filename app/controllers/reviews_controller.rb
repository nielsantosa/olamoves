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
    @order = Order.where(video: @video, user: current_user, confirmed: true)
    if @order.exists?
      if @review.save
        redirect_to video_path(@video)
      else
        render :new
      end
    else
      redirect_to video_path(@video)
    end
  end

  def edit
    @video = Video.find(params[:video_id])
    @review = Review.find(params[:id])
  end

  def update
    @review = Review.find(params[:id])
    @video = Video.find(params[:video_id])
    @review.update(review_params)
    if @review.save
      redirect_to video_path(@video)
    else
      render :edit
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
