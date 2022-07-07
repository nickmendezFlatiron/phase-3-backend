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

  # Post Requests
  post '/appointments' do
    new_appointment = Appointment.create({
      dog_id: params[:dog_id] ,
      employee_id: params[:employee_id] , 
      walk_duration: params[:walk_duration] ,
      date: params[:date] ,
      time: params[:time]
    })
    new_appointment.to_json
  end
end
