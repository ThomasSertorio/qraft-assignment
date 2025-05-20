require "json"
require_relative "lib/car"
require_relative "lib/rental"

# Load input
input = JSON.parse(File.read("data/input.json"), symbolize_names: true)

# Build cars lookup
cars = input[:cars].each_with_object({}) do |car_data, hash|
  car = Car.new(**car_data)
  hash[car.id] = car
end

# Build rentals lookup
rentals = input[:rentals].each_with_object({}) do |rental_data, hash|
  car = cars[rental_data[:car_id]]
  rental = Rental.new(**rental_data.except(:car_id).merge(car:))
  hash[rental.id] = rental
end

# Output
output = { rentals: rentals.values.map { |rental| {id: rental.id, price: rental.price }} }

File.write("data/output.json", JSON.pretty_generate(output))
puts "✅ Output written to output.json"
