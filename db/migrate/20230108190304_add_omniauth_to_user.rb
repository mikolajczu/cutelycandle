class AddOmniauthToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :name, :string
    add_column :users, :image, :string
    add_column :users, :uid, :string
    add_column :users, :provider, :string
  end
end
