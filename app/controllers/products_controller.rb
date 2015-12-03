class ProductsController < ApplicationController
  
  def index
  end

  def new
  	@product = Product.new
  end

  def edit
  end

  def show
  end

  def create
  	@product = Product.create( product_params )
  	redirect_to @product
  end

  private

  def product_params
		params.require(:product).permit(:image,:title)
  end
end
