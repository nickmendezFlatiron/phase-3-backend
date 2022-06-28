class CreateEmployeesTable < ActiveRecord::Migration[6.1]
  def change
    create_table :employees do |t|
      t.string :employee_name
      t.text :address
      t.string :phone_number
      t.integer :wage
      t.integer :hours_worked
      t.string :position
    end 
  end
end
