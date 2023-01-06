class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.string :name
      t.integer :price
      t.integer :sales_count, null: false, default: 0

      t.timestamps
    end
  end
end
