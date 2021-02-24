puts "Start seeding 🍑"

puts "Cleaning videos data 🧹"
Video.destroy_all

10.times do
  title = Faker::Restaurant.name
  description = Faker::Restaurant.description
  price = (0..200).step(10).to_a.sample
  difficulty = (1..5).to_a.sample
  duration = (5..20).to_a.sample
  video_url = "video_url"
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
