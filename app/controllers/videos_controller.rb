class VideosController < ApplicationController
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

  end
end
