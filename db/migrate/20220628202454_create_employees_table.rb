class CreateEmployeesTable < ActiveRecord::Migration[6.1]
  def change
    create_table :employees do |t|
      t.string :employee_name
      t.text :address
      t.string :email
      t.string :phone_number
      t.string :position
      t.decimal :wage
      t.decimal :hours_worked 
      t.decimal :hours_ytd
      t.timestamps
    end 
  end
end
