puts "Start seeding 🍑"

puts "Cleaning users data 🧹"
User.destroy_all

puts "Cleaning videos data 🧹"
Video.destroy_all

puts "Cleaning purchases data 🧹"
Purchase.destroy_all

puts "Cleaning orders data 🧹"
Order.destroy_all

puts "Creating instructors..."

5.times do
  name = Faker::Name.name
  email = Faker::Internet.email
  password = "testtest"
  puts "Creating User #{name}"
  user = User.new(name: name, email: email, password: password, instructor: true)
  user.save!
end

def generate_pexel_video
  pexels_key = "563492ad6f9170000100000138c8f4c57b1c4c69a53d72daaeb561d3" # Your authentication key
  client = Pexels::Client.new(pexels_key) # Set up the client

  pexels_json_parsed = client.videos.search('yoga') # Search for videos with keyword "waves", return json files with 15 results
  videos = pexels_json_parsed.videos
  # video_url = pexels_json_parsed.videos[0].files[0].link # Choose the first video, take the first video file type (there are HD, SD, etc. options), then take the url link
  # video_type = pexels_json_parsed.videos[0].files[0].file_type # Similar to line above, but take the video type
  # [video_url, video_type]
end

def generate_video(selected_videos)
  chosen_video = Video.all.sample

  while selected_videos.include?(chosen_video)
    chosen_video = Video.all.sample
  end

  selected_videos << chosen_video

  [selected_videos, chosen_video]
end

puts "Generating videos from pexel video API"
videos = generate_pexel_video

puts "Generating Videos - start"
(0..10).to_a.each do |i|
  title = Faker::Restaurant.name
  description = Faker::Restaurant.description
  price = (0..200).step(10).to_a.sample
  difficulty = (1..5).to_a.sample
  duration = (5..20).to_a.sample
  video_url = videos[i].files[0].link
  video_type = videos[i].files[0].file_type

  puts "Creating video #{title}"
  Video.create!(
    title: title,
    description: description,
    price: price,
    difficulty: difficulty,
    duration: duration,
    video_url: video_url,
    video_type: video_type,
    user: User.where(instructor: true).sample)
end

puts "Creating Users - start"
3.times do
  name = Faker::Name.name
  email = Faker::Internet.email
  password = "testtest"
  puts "Creating User #{name}"
  user = User.new(name: name, email: email, password: password)
  user.save!

  # Empty array to check if videos has been selected
  selected_videos = []

  puts "Creating Confirmed Orders - start"
  (1..3).to_a.each do |i|
    selected_videos, chosen_video = generate_video(selected_videos)

    purchase = Purchase.create!

    puts "Creating confirmed orders - #{i}"
    Order.create!(video: chosen_video, user: user, confirmed: true, purchase: purchase)
  end
  puts "Creating Unconfirmed Orders - start"
  (1..4).to_a.each do |i|
    selected_videos, chosen_video = generate_video(selected_videos)

    puts "Creating unconfirmed orders - #{i}"
    Order.create!(video: chosen_video, user: user, confirmed: false)
  end
end


puts "Finish seeding 🍑"
