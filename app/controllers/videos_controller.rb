class VideosController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
  before_action :set_video, only: [:show, :edit, :update, :destroy]

  def index
    # show all the videos
    if @query = params[:search]
      @videos = Video.where("lower(title) LIKE lower(?)", "%#{@query}%")
    else
      @videos = Video.all
    end
  end

  def show
    @video = Video.find(params[:id])
    @order = Order.find_by(video: @video, user: current_user, confirmed: true)
    @review = Review.find_by(video: @video, user: current_user)
  end

  def difficulty
    @videos = Video.where(difficulty: params[:level])
    render :index
  end

  def new
    if current_user.instructor?
      @video = Video.new
      current_user = @video.user
    end
  end

  def create
    @video = Video.new(video_params)
    if @video.save
      redirect_to video_path(@video)
    else
      render :new
    end
  end

  def edit
    if @video.user == current_user
      render :edit
    else
      redirect_to myprofile_path
      flash.alert = 'You cannot edit this video'
    end
  end

  def update
    if @video.user_id == current_user.id && @video.update(video_params)
      redirect_to video_path(@video)
    else
      render :edit
    end
  end

  def destroy
    if @video.destroy
      redirect_to myprofile_path
    end
  end

  private

  def set_video
    @video = Video.find(params[:id])
  end

  def video_params
    params.require(:video).permit(:title, :description, :difficulty, :duration, :video_url, :video_type, :price_cents, :user_id)
  end
end
