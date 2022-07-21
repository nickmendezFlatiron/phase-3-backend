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

  get '/employees' do
    employee = Employee.all
    employee.to_json(include: :appointments)
  end 


  # Post Requests
  post '/appointments' do
    
    dog_name = Dog.find(params[:dog_id])
    employee_name = Employee.find(params[:employee_id])

    exist = Appointment.where({
      start: params[:start] , 
      dog_id: params[:dog_id]
      }).or(Appointment.where({start: params[:start] , employee_id: params[:employee_id]}))

      if exist.length < 1
        new_appointment = Appointment.find_or_create_by({
          dog_id: params[:dog_id] ,
          employee_id: params[:employee_id] , 
          walk_duration: params[:walk_duration] ,
          start: params[:start] ,
          end: params[:end] ,
          title: dog_name[:dog_name]
        })
        new_appointment.to_json
      else
        {error: "Appointment unsuccessful ,schedule conflict with either #{dog_name[:dog_name]} or #{employee_name[:employee_name]}"}.to_json
      end 
  end

  post '/dogs' do

    new_dog = Dog.create({
      dog_name: params[:dog_name] ,
      dog_image: params[:dog_image] ,
      dog_weight: params[:dog_weight] ,
      owner_id: params[:owner_id]
    })
    new_dog.to_json
  end

  # Delete Requests
  delete '/appointments/:id' do
    appointment = Appointment.find(params[:id])
    appointment.destroy
    appointment.to_json
  end 

  delete '/dogs/:id' do

  end 

  # Patch Requests (update)
  patch '/appointments/:id' do
    appointment = Appointment.find(params[:id])
    employee = Employee.find(params[:employee_id])
    exist = Appointment.where({start: appointment[:start] , employee_id: params[:employee_id]})
    
    if exist.exists? 
      { error: "Update unsuccessful ,#{employee[:employee_name]} has appointment scheduled at that time" }.to_json
    else
      appointment.update({
        employee_id: params[:employee_id] ,
        walk_duration: params[:walk_duration]
      })
      appointment.to_json
    end
  end

  patch '/employees/:id' do 
    employee = Employee.find(params[:id])
    employee.update({
      hours_worked: params[:hours_worked]
    })
    employee.to_json(include: :appointments)
  end
end
