class CreateAppointmentsTable < ActiveRecord::Migration[6.1]
  def change
    create_table :appointments do |t|
      # time HH:MM:SS
      t.time :time
      # date YYYY-MM-DD
      t.date :date
      t.integer :walk_duration
    end
  end
end 
