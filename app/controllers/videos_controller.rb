class VideosController < ApplicationController
  def index
    # show all the videos
    @videos = Video.all
  end

  def show
    @video = Video.find(params[:id])
  end
end
