class CreateAppointmentsTable < ActiveRecord::Migration[6.1]
  def change
    create_table :appointments do |t|
      # YYYY-MM-DD HH:MM:SS
      t.datetime :start
      t.datetime :end
      t.integer :walk_duration
      t.string :title
      t.timestamps
    end
  end
end 
