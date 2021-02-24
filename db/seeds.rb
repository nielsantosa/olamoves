puts "Start seeding 🍑"

puts "Cleaning videos data 🧹"
Video.destroy_all

def generate_pexel_video
  pexels_key = "563492ad6f9170000100000138c8f4c57b1c4c69a53d72daaeb561d3" # Your authentication key
  client = Pexels::Client.new(pexels_key) # Set up the client

  pexels_json_parsed = client.videos.search('yoga') # Search for videos with keyword "waves", return json files with 15 results
  video_url = pexels_json_parsed.videos[0].files[0].link # Choose the first video, take the first video file type (there are HD, SD, etc. options), then take the url link
  video_type = pexels_json_parsed.videos[0].files[0].file_type # Similar to line above, but take the video type
  [video_url, video_type]
end

video_url, video_type = generate_pexel_video

10.times do
  title = Faker::Restaurant.name
  description = Faker::Restaurant.description
  price = (0..200).step(10).to_a.sample
  difficulty = (1..5).to_a.sample
  duration = (5..20).to_a.sample
  puts "Creating video #{title}"
  Video.create!(
    title: title,
    description: description,
    price: price,
    difficulty: difficulty,
    duration: duration,
    video_url: video_url)
end

puts "Finish seeding 🍑"
