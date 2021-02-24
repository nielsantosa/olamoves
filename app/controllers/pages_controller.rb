class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home

  def home
  end

  def myprofile
    @user = current_user

    raise
    @videos = Video.where(user: @user)
  end
end
