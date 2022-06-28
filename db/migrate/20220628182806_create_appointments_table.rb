class CreateAppointmentsTable < ActiveRecord::Migration[6.1]
  def change
    create_table :appointments do |t|
      t.time :time
      t.date :date
      t.references :dog
      t.references :employee
    end
  end
end 
