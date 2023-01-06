class Product < ApplicationRecord
    has_many :product_categories
    has_many :categories, through: :product_categories

    def to_s
        name
    end

    after_create do
        product = Stripe::Product.create(name: name)
        price = Stripe::Price.create(product: product, unit_amount: self.price, currency: "pln")
        update(stripe_product_id: product.id, stripe_price_id: price.id)
    end

    def to_builder
        Jbuilder.new do |product|
            product.price stripe_price_id
            product.quantity 1
        end
    end

    after_update :create_and_assign_new_stripe_price, if: :saved_change_to_price?

    def create_and_assign_new_stripe_price
        price = Stripe::Price.create(product: self.stripe_product_id, unit_amount: self.price, currency: "pln")
        update(stripe_price_id: price.id)
    end

end
