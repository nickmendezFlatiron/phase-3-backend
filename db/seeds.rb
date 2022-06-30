puts "🌱 Seeding..."

# Seed your database here

#create dog walkers
10.times do 
  Employee.create({
    employee_name: Faker::Name.name,
    email: Faker::Internet.email ,
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
URL = 'https://dog.ceo/api/breeds/image/random'
uri = URI.parse(URL)

20.times do
  # Send get request to Dog API 
  res = Net::HTTP.get_response(uri)
  random = JSON.parse(res.body)
  dog_img = random["message"]
  
  random = rand(1..15)
  Dog.create({
    dog_name: Faker::Creature::Dog.name ,
    dog_weight: Faker::Number.number(digits: 2) ,
    dog_image: dog_img ,
    owner_id: random 
  })
end 


# create appointments
# time HH:MM:SS
# date YYYY-MM-DD
10.times do
  random_dog = rand(1..20)
  Appointment.create({
    time: "12:30:01" ,
    date: "2022-08-06" ,
    walk_duration: 30 ,
    dog_id: random_dog ,
    employee_id: rand(1..10) 
  })
end 


puts "✅ Done seeding!"
