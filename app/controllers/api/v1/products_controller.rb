class Api::V1::ProductsController < ApplicationController
  def index
    products = Product.all
    render json: products, status: 200
  end

  def show
    product = Product.find_by(id: params[:id])
    if product
      render json: product, status: 200
    else
      render json: {error: "Not Found"}
    end
  end

  def create
    product = Product.new(
      name: prod_params[:name],
      brand: prod_params[:brand],
      price: prod_params[:price]
      )
    if product.save
      render json: product, status: 200
    else
      render json: {error: "Product not create"}
    end
  end

  private
  def prod_params
   params.require(:product).permit([:name, :brand, :price ])
 end
end
