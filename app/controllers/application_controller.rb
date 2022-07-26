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

    appt_in_progress_dogs = Appointment.all.find_all {|a| a[:dog_id] == params[:dog_id]}.find_all {|a| params[:start].between?(a[:start] , a[:end])}
    appt_in_progress_walkers = Appointment.all.find_all {|a| a[:employee_id] == params[:employee_id]}.find_all {|a| params[:start].between?(a[:start] , a[:end])}

    if !exist.exists? && [*appt_in_progress_dogs,*appt_in_progress_walkers].length < 1
      new_appointment = Appointment.create({
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

    appt_in_progress_walkers = Appointment.all.find_all {|a| a[:employee_id] == params[:employee_id]}.find_all {|a| params[:start].between?(a[:start] , a[:end])}
    
    if exist.exists? || [*appt_in_progress_walkers].length > 0
      { error: "Update unsuccessful , #{employee[:employee_name]} has appointment scheduled for that date/time." }.to_json
    else
      appointment.update({
        employee_id: params[:employee_id] ,
        walk_duration: params[:walk_duration] ,
        end: params[:end]
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
