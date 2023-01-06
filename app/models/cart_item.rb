class CartItem < ApplicationRecord
  belongs_to :product

  def to_builder
    Jbuilder.new do |cart_item|
        cart_item.price product.stripe_price_id
        cart_item.quantity quantity
    end
  end

end
