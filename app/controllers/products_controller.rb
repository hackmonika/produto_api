class ProductsController < ApplicationController
  before_action :authenticate_user
  before_action :set_product, only: [:show, :update, :destroy]

  # GET /products
  def index
    @products = Product.all.includes(image_attachment: :blob)
    render json: @products.map { |product| product_with_image(product) }
  end

  # GET /products/:id
  def show
    render json: product_with_image(@product)
  end

  # POST /products
  def create
    @product = Product.new(product_params)
    if @product.save
      render json: product_with_image(@product), status: :created
    else
      render json: @product.errors, status: :unprocessable_entity
    end
  end

  # PATCH /products/:id
  def update
    if @product.update(product_params)
      render json: product_with_image(@product)
    else
      render json: @product.errors, status: :unprocessable_entity
    end
  end

  # DELETE /products/:id
  def destroy
    @product.destroy
    head :no_content
  end

  private

  # Find product by ID
  def set_product
    @product = Product.find(params[:id])
  end

  # Permit parameters
  def product_params
    params.require(:product).permit(:name, :price, :stock_quantity, :description, :image)
  end

  # Add image URL to product JSON
  def product_with_image(product)
    product.as_json.merge(image_url: product.image.attached? ? url_for(product.image) : nil)
  end
end
