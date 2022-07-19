class CreateDogsTable < ActiveRecord::Migration[6.1]
  def change
    create_table :dogs do |t|
      t.string :dog_name
      t.string :dog_image , default: './src/assets/stock.jpg'
      t.integer :dog_weight 
    end 
  end
end
