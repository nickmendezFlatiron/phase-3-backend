class CreateOwnersTable < ActiveRecord::Migration[6.1]
  def change

    create_table :owners do |t|
      t.string :owner_name
      t.string :phone_number
      t.string :email
      t.text :address
    end 
  end
end
