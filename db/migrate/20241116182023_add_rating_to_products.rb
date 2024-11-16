class AddRatingToProducts < ActiveRecord::Migration[7.2]
  def change
    add_column :products, :rating, :integer
  end
end
