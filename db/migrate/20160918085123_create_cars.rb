class CreateCars < ActiveRecord::Migration
  def change
    create_table :cars do |t|
      t.text :position
      t.boolean :available

      t.timestamps null: false
    end
  end
end
