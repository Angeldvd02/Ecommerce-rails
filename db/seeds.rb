# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

require 'faker'

Faker::Config.locale = 'es'

# Crear Categorías
10.times do
  Category.create!(
    name: Faker::Commerce.department,
    description: Faker::Lorem.sentence,
    # image: Faker::LoremFlickr.image(size: "300x300", search_terms: ['clothing'])
  )
end

# Crear Productos
50.times do
  Product.create!(
    name: Faker::Commerce.product_name,
    description: Faker::Lorem.paragraph,
    image: Faker::LoremFlickr.image(size: "300x300", search_terms: ['clothing']),
    price: Faker::Commerce.price(range: 100..1000),
    category_id: Category.pluck(:id).sample,
    active: [true, false].sample
  )
end

# Crear Órdenes
20.times do
  Order.create!(
    customer_email: Faker::Internet.email,
    fulfilled: [true, false].sample,
    total: Faker::Commerce.price(range: 100..5000),
    address: Faker::Address.full_address
  )
end

# Crear OrderProducts
100.times do
  OrderProduct.create!(
    product_id: Product.pluck(:id).sample,
    order_id: Order.pluck(:id).sample,
    size: ['S', 'M', 'L', 'XL'].sample,
    quantity: Faker::Number.between(from: 1, to: 10)
  )
end

# Crear Stocks
Product.all.each do |product|
  ['S', 'M', 'L', 'XL'].each do |size|
    Stock.create!(
      size: size,
      amount: Faker::Number.between(from: 10, to: 100),
      product_id: product.id
    )
  end
end

p "Seed creado"