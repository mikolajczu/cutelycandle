class Product < ApplicationRecord
    has_many :product_categories
    has_many :categories, through: :product_categories

    def to_s
        name
    end

end
