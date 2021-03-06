  class ProductsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_product, only: [:edit, :show, :update, :destroy]
  before_action :its_admin?

  
  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      flash[:notice] = 'The product have been saved'
      redirect_to product_path(id: @product.id , it_was: 'created')
    else
      @erros = @product.errors
      render :new
    end
  end

  def edit
    
  end

  def update
    if @product.update(product_params)
       flash[:alert] = 'Product was sucessfully updated'
       redirect_to product_path(id: @product.id , it_was: 'updated')
    else
      render :edit
    end
  end

  def index
    @products = Product.all
  end

  def destroy
    @product.destroy
    flash[:flash] = 'Product was sucessfully destroyed'
    redirect_to products_path

  end

  def show
    @action = params[:it_was]
  end

  private
  #Never trust parameters from the scary internet, only allow the white list through.
    def product_params
      params.require(:product).permit(:name, :reference, :price, :quantity, :brand, :description, :category_id, :image)
    end

    def find_product
      @product = Product.find(params[:id])
    end

    def its_admin?
      unless current_user.admin?
        redirect_to root_path, :alert["Acceso denegado"]
      end
    end
end
