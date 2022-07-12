class ApplicationController < Sinatra::Base
  set :default_content_type, 'application/json'
  
  # Add your routes here
  get "/" do
    { message: "Good luck with your project!" }.to_json
  end

  get "/owners" do
    owner = Owner.all
    owner.to_json(include: { dogs: { include: :appointments }})
  end 


  get "/appointments" do
    appointment = Appointment.all
    appointment.to_json
  end 

  # Post Requests
  post '/appointments' do
    dog_name = Dog.find(params[:dog_id])
    new_appointment = Appointment.create({
      dog_id: params[:dog_id] ,
      employee_id: params[:employee_id] , 
      walk_duration: params[:walk_duration] ,
      start: params[:start] ,
      end: params[:end] ,
      title: dog_name[:dog_name]
    })

    new_appointment.to_json
  end
end
