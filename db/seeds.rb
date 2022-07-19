puts "🌱 Seeding..."

# Seed your database here

#create dog walkers
10.times do 
  Employee.create({
    employee_name: Faker::Name.unique.name,
    email: Faker::Internet.email ,
    address: Faker::Address.full_address,
    phone_number: Faker::PhoneNumber.phone_number,
    wage: Faker::Number.number(digits: 2),
    hours_worked: Faker::Number.number(digits: 2),
    position: "walker" 
  })
end 

4.times do 
  Employee.create({
    employee_name: Faker::Name.unique.name,
    email: Faker::Internet.email ,
    address: Faker::Address.full_address,
    phone_number: Faker::PhoneNumber.phone_number,
    wage: Faker::Number.number(digits: 2),
    hours_worked: Faker::Number.number(digits: 2),
    position: Faker::Job.title
  })
end 

# create owners

15.times do 
  Owner.create({
    owner_name: Faker::Name.unique.name,
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
    dog_name: Faker::Creature::Dog.unique.name ,
    dog_weight: Faker::Number.number(digits: 2) ,
    dog_image: dog_img ,
    owner_id: random 
  })
end 


# create appointments
# time HH:MM:SS
# date YYYY-MM-DD
50.times do
  random_dog = rand(1..20)
  random_employee = rand(1..10)
  random_date = rand(1..23)
  dog = Dog.find(random_dog)
 
  exist = Appointment.where({start: "2022-08-#{random_date} #{random_date}:00:01" , dog_id: random_dog}).or(Appointment.where({start: "2022-08-#{random_date} #{random_date}:00:01" , employee_id: random_employee}))

  if exist.length < 1
   Appointment.create({start: "2022-08-#{random_date} #{random_date}:00:01" , end: "2022-08-#{random_dog} #{random_dog}:30:01" , walk_duration: 30 , title: dog[:dog_name] , dog_id: random_dog , employee_id: random_employee})
  end

   
end 


puts "✅ Done seeding!"
