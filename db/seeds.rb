puts "🌱 Seeding spices..."

# Seed your database here

#create dog walkers
10.times do 
  Employee.create({
    employee_name: Faker::Name.name,
    address: Faker::Address.full_address,
    phone_number: Faker::PhoneNumber.phone_number,
    wage: Faker::Number.number(digits: 2),
    hours_worked: Faker::Number.number(digits: 2),
    position: "walker" 
  })
end 

# create owners

15.times do 
  Owner.create({
    owner_name: Faker::Name.name,
    address: Faker::Address.full_address,
    phone_number: Faker::PhoneNumber.phone_number,
    email: Faker::Internet.email
  })
end 


# create dogs
20.times do
  random = rand(1..15)
  Dog.create({
    dog_name: Faker::Creature::Dog.name ,
    dog_weight: Faker::Number.number(digits: 2) ,
    dog_image: nil ,
    owner_id: random 
  })
end 


# create appointments

10.times do
  random = rand(1..20)
  random_employee = random = rand(1..10)
  Appointment.create({
    time: nil,
    date: nil,
    walk_duration: 30,
    dog_id: random ,
    employee_id: random_employee ,
  })
end 


puts "✅ Done seeding!"
