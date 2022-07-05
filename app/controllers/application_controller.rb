class ApplicationController < Sinatra::Base
  set :default_content_type, 'application/json'
  
  # Add your routes here
  get "/" do
    { message: "Good luck with your project!" }.to_json
  end

  get "/owners" do
    owner = Owner.all
    owner.to_json(include: :dogs)
  end 

  get "/all" do
    owner = Owner.order(:owner_name).all
    dog = Dog.order(:dog_name).all 
    employee = Employee.order(:employee_name).all
    appointment = Appointment.all

    
    { dogs: dog ,
      owners: owner , 
      employees: employee ,
      appointments: appointment
    }.to_json
  end 
end
