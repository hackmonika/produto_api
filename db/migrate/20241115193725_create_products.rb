class CreateProducts < ActiveRecord::Migration[7.2]
  def change
    create_table :products do |t|
      t.string :name
      t.float :price
      t.integer :stock_quantity
      t.text :description

      t.timestamps
    end
  end
end
