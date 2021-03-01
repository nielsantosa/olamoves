class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home, :instructors, :instructorvideos]

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

    #for popular videos (not filtered by popular yet)
    @videos = Video.all.sort_by(&:created_at)
    @videos_one_p = @videos[0]
    @videos_two_p = @videos[1]
    @videos_three_p = @videos[2]
    @videos_four_p = @videos[3]
    @videos_five_p = @videos[4]
    @videos_six_p = @videos[5]
    @videos_seven_p = @videos[6]
    @videos_eight_p = @videos[7]
    @videos_nine_p = @videos[8]

    # @pop_vid = Video.where("price > 100").order(:price).reverse_order
  end

  def myprofile
    @user = current_user
    @purchased_order = Order.where(user: @user, confirmed: true)
    @purchased_videos = @purchased_order.map do |order|
      order.video
    end
  end

  def workout
    Workout.create(date: Time.now, user: current_user)
    redirect_to user_root_path
  end

  def user
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
    user = current_user
    @goals = Goal.where(user: user, completed: false)

    @workout = Workout.where(user: current_user).group("DATE_TRUNC('week', date)").count.values.last
    @workout = 0 if @workout.nil?



    pexels_key = "563492ad6f9170000100000138c8f4c57b1c4c69a53d72daaeb561d3" # Your authentication key
    client = Pexels::Client.new(pexels_key) # Set up the client
    pexels_json_parsed = client.videos.search('meditation') # Search for videos with keyword "waves", return json files with 15 results
    @video_url = pexels_json_parsed.videos[0].files[0].link # Choose the first video, take the first video file type (there are HD, SD, etc. options), then take the url link
  end

  def instructors
    @users = User.where(instructor: true)
  end

  def instructorvideos
    @user = User.find(params[:id])
    @videos = @user.videos
  end
end
