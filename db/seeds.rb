puts "🌱 Seeding spices..."

# Seed your database here


# create dogs
20.times do
  Dog.create({
    dog_name: Faker::Creature::Dog.name ,
    dog_weight: Faker::Number.number(digits: 2) ,
    dog_image: nil ,
    owner_id: nil
  })
end 


puts "✅ Done seeding!"
