class AddImageToProducts < ActiveRecord::Migration[7.1]
  def change
    add_column :products, :image, :string
    add_column :categories, :image, :string
  end
end
