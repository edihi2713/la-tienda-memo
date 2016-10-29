class PurchasesController < ApplicationController
	before_action :authenticate_user!, only: :create

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


end
