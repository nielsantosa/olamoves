class VideosController < ApplicationController
  def index
    # show all the videos
    @videos = Video.all
  end

  def show
  end
end
