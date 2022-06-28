class CreateDogsTable < ActiveRecord::Migration[6.1]
  def change
    create_table :dogs do |t|
      t.string :dog_name
      t.string :dog_image
      t.integer :dog_weight 
    end 
  end
end
