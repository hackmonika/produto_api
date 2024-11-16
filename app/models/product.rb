class Product < ApplicationRecord
  has_one_attached :image

  validates :name, :price, :stock_quantity, :description, presence: true
  validates :price, numericality: { greater_than: 0 }
  validates :stock_quantity, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
end

