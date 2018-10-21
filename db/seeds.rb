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



ORDERITEMS_FILE = Rails.root.join('db', 'seed_data', 'merchants.csv')
puts "Loading raw merchant data from #{ORDERITEMS_FILE}"

merchant_failures = []

CSV.foreach(ORDERITEMS_FILE, :headers => true) do |row|
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
