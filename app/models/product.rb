class Product < ApplicationRecord
    has_many :product_categories
    has_many :categories, through: :product_categories

    def to_s
        name
    end

    def to_builder
        Jbuilder.new do |product|
            product.price price
            product.quantity 1
        end
    end

end
