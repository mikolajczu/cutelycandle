class CartItemsController < ApplicationController

    def remove_from_cart
        id = params[:id].to_i
        session[:cart].delete(id)
        redirect_to products_path
    end

end