class PurchasesController < ApplicationController
	before_action :authenticate_user!, only: :create
	before_action :is_admin?, only: [ :update, :dashboard, :destroy ]

	def create
		product = Product.find(params[:product_id])

		purchase = Purchase.new
		purchase.product = product
		purchase.user = current_user
		purchase.status = :pending
		purchase.price = product.price


		if product.available? && purchase.save
		   product.update_stock
			flash[:notice] = 'Tu compra se hizo exitosamente'
		else
			flash[:alert] = 'La compra no se pudo completar, intente más tarde'
		end

		redirect_to root_path(category_id: product.category_id)

	end

	def update
		purchase = Purchase.find(params[:id])
		if purchase.update(status: :paid)
			flash[:notice] = 'Tu compra se pagó exitosamente'
		else
			flash[:alert] = 'El pago no se pudo completar, intente más tarde'
		end
		redirect_to profile_path(id: params[:user_id])
	end

	def destroy
		@purchase = Purchase.find(params[:id])
	    @purchase.destroy
	    flash[:notice] = 'La compra se eliminó exitosamente'
	    redirect_to profile_path(id: params[:user_id])
  	end

	def dashboard
		@users = User.all
	end

	private
	def is_admin?
      unless current_user.admin?
        redirect_to root_path, :alert["Acceso denegado"]
      end
    end

end
