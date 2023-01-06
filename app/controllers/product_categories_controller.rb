class ProductCategoriesController < ApplicationController
    belongs_to :categories
    belongs_to :products
end
