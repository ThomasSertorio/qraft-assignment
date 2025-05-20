RSpec.describe Rental do
  let(:car) { Car.new(id: 1, price_per_day: 2000, price_per_km: 10) }

  it "calculates the duration correctly" do
    rental = Rental.new(id: 1, car:, start_date: "2017-12-8", end_date: "2017-12-10", distance: 100)
    expect(rental.duration).to eq(3)
  end

  it "calculates the price correctly when no discount can be applied" do
    rental = Rental.new(id: 1, car:, start_date: "2017-12-8", end_date: "2017-12-8", distance: 100)
    expect(rental.price).to eq(3000) # [(1 * 2000)] + 100 * 10
  end

  it "calculates the price correctly when all discounts are applied" do
    rental = Rental.new(id: 1, car:, start_date: "2017-12-8", end_date: "2017-12-27", distance: 100)
    expect(rental.price).to eq(26800) # [(1 * 2000) + (3 * 2000 * (1 - 0.1)) + (6 * 2000 * (1 - 0.3)) + (10 * 2000 * (1 - 0.5))] + 100 * 10
  end

  it "calculates the price correctly" do
    rental = Rental.new(id: 1, car:, start_date: "2017-12-8", end_date: "2017-12-10", distance: 100)
    expect(rental.price).to eq(6600) # [(1 * 2000) + (2 * 2000 * (1 - 0.10))] + 100 * 10
  end
end
