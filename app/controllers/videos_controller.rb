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
end
