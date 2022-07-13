class ApplicationController < Sinatra::Base
  set :default_content_type, 'application/json'
  
  get "/owners" do
    owner = Owner.all
    owner.to_json(include: { dogs: { include: :appointments }})
  end 

  get "/appointments" do
    appointment = Appointment.all.order(:start)
    appointment.to_json
  end 

  get "/walkers" do
    employee = Employee.all.find_all {|employee| employee[:position] == "walker"}
    employee.to_json
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

  # Delete Requests
  delete '/appointments/:id' do
    appointment = Appointment.find(params[:id])
    appointment.destroy
    appointment.to_json
  end 

end
