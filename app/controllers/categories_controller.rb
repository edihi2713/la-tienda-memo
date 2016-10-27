class CategoriesController < ApplicationController
  
  #No permite hacer los métodos
  before_action :authenticate_user!

  before_action :find_category, only: [:edit, :show, :update, :destroy]

  def new
    @category = Category.new
    @action = 'Crear'
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:notice] = 'La categoría se guardó exitosamente'
      #redirect_to category_path(id: @category.id)
    
      redirect_to categories_path, notice: "La categoría se guardó exitosamente"
    else
      @errors = @category.errors
      render :new
    end
  end

  def edit
    @action = 'Editar'
  end

  def update
    if @category.update(category_params)
       flash[:notice] = 'La categoría se actualizó exitosamente'
       redirect_to category_path
      # redirect_to product_path(id: @product.id , it_was: 'updated')
    else
      render :edit
    end
  end

  def show

  end

  def destroy

    @category.destroy
    flash[:notice] = 'Product was sucessfully destroyed'
    redirect_to categories_path
  end

  def index
    @categories = Category.all
  end

  private
    def category_params
      params.require(:category).permit(:name, :description)
    end

    def find_category
      @category = Category.find(params[:id])
    end
end
