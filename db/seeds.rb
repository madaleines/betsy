require 'csv'

MERCHANT_FILE = Rails.root.join('db', 'seed_data', 'merchants.csv')
puts "Loading raw merchant data from #{MERCHANT_FILE}"

merchant_failures = []

CSV.foreach(MERCHANT_FILE, :headers => true) do |row|
  merchant = Merchant.new
  merchant.id = row['id']
  merchant.username = row['username']
  merchant.email = row['email']
  merchant.uid = row['uid']
  merchant.provider = row['provider']

  succesful = merchant.save
  if !successful
    merchant_failures << merchant
  puts "Failed to save merchants: #{merchant.inspect}"

  else
    puts "Created merchant: #{merchant.inspect}"
  end
end

puts "Added #{Merchant.count} merchant records"
puts "#{merchant_failures.length} merchants failed to save"



CATEGORY_FILE = Rails.root.join('db', 'seed_data', 'categories.csv')
puts "Loading raw category data from #{CATEGORY_FILE}"

category_failures = []

CSV.foreach(CATEGORY_FILE, :headers => true) do |row|
  category = Category.new
  category.name = row['name']

  succesful = category.save
  if !successful
    category_failures << category
  puts "Failed to save categories: #{category.inspect}"

  else
    puts "Created category: #{category.inspect}"
  end
end

puts "Added #{Category.count} category records"
puts "#{category_failures.length} categories failed to save"



ORDERITEMS_FILE = Rails.root.join('db', 'seed_data', 'order_items.csv')
puts "Loading raw order item data from #{ORDERITEMS_FILE}"

order_items_failures = []

CSV.foreach(ORDERITEMS_FILE, :headers => true) do |row|
  order_item = OrderItem.new
  order_item.order_id = row['order_id']
  order_item.product_id = row['product_id']
  order_item.quantity = row['quantity']
  order_item.status = row['status']

  succesful = order_item.save
  if !successful
    order_item_failures << order_item
  puts "Failed to save order_items: #{order_item.inspect}"

  else
    puts "Created order_item: #{order_item.inspect}"
  end
end

puts "Added #{OrderItem.count} order_item records"
puts "#{order_item_failures.length} order_items failed to save"



REVIEWS_FILE = Rails.root.join('db', 'seed_data', 'reviews.csv')
puts "Loading raw review data from #{REVIEWS_FILE}"

review_failures = []

CSV.foreach(REVIEWS_FILE, :headers => true) do |row|
  review = Review.new
  review.rating = row['rating']
  review.product_id = row['product_id']
  oreview.description = row['description']


  succesful = review.save
  if !successful
    review_failures << review
  puts "Failed to save reviews: #{review.inspect}"

  else
    puts "Created reviews: #{review.inspect}"
  end
end

puts "Added #{Review.count} review records"
puts "#{review_failures.length} reviews failed to save"
