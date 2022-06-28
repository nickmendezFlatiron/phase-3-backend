class CreateTableAssociations < ActiveRecord::Migration[6.1]
  def change
    add_reference :appointments, :dog, foreign_key: true
    add_reference :appointments, :employee, foreign_key: true
    add_reference :dogs, :owner, foreign_key: true
  end
end
