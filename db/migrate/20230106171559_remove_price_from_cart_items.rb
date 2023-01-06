class RemovePriceFromCartItems < ActiveRecord::Migration[7.0]
  def change
    remove_column :cart_items, :price
  end
end
