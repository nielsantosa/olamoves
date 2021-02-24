class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home

  def home
    pexels_key = "563492ad6f9170000100000138c8f4c57b1c4c69a53d72daaeb561d3" # Your authentication key
    client = Pexels::Client.new(pexels_key) # Set up the client
    @videos = Video.all
    pexels_json_parsed = client.videos.search('yoga') # Search for videos with keyword "waves", return json files with 15 results
    @video_url = pexels_json_parsed.videos[0].files[0].link # Choose the first video, take the first video file type (there are HD, SD, etc. options), then take the url link
    @video_type = pexels_json_parsed.videos[0].files[0].file_type # Similar to line above, but take the video type
    p pexels_json_parsed
    puts @video_url
    puts @video_type

  end
end
