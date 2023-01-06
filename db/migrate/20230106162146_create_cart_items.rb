class CreateCartItems < ActiveRecord::Migration[7.0]
  def change
    create_table :cart_items do |t|
      t.references :product, null: false, foreign_key: true
      t.integer :price
      t.integer :quantity

      t.timestamps
    end
  end
end
