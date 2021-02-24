puts "Start seeding 🍑"


10.times do
  title = Faker::Restaurant.name
  description = Faker::Restaurant.description
  price = (0..200).step(10).to_a.sample
  difficulty = (1..5).to_a.sample
  duration = (5..20).to_a.sample
end

puts "Finish seeding 🍑"
