RSpec.describe Rental do
  let(:car) { Car.new(id: 1, price_per_day: 2000, price_per_km: 10) }

  it "calculates the duration correctly" do
    rental = Rental.new(id: 1, car: car, start_date: "2017-12-8", end_date: "2017-12-10", distance: 100)
    expect(rental.duration).to eq(3)
  end

  it "calculates the price correctly when no discount can be applied" do
    rental = Rental.new(id: 1, car: car, start_date: "2017-12-8", end_date: "2017-12-8", distance: 100)
    expect(rental.price).to eq(3000) # [(1 * 2000)] + 100 * 10
  end

  it "calculates the price correctly when all discounts are applied" do
    rental = Rental.new(id: 1, car: car, start_date: "2017-12-8", end_date: "2017-12-27", distance: 100)
    expect(rental.price).to eq(26800) # [(1 * 2000) + (3 * 2000 * (1 - 0.1)) + (6 * 2000 * (1 - 0.3)) + (10 * 2000 * (1 - 0.5))] + 100 * 10
  end

  it "calculates the price correctly" do
    rental = Rental.new(id: 1, car: car, start_date: "2017-12-8", end_date: "2017-12-10", distance: 100)
    expect(rental.price).to eq(6600) # [(1 * 2000) + (2 * 2000 * (1 - 0.10))] + 100 * 10
  end

  it "calculates the price correctly" do
    rental = Rental.new(id: 1, car: car, start_date: "2017-12-8", end_date: "2017-12-10", distance: 100)
    expect(rental.price).to eq(6600) # [(1 * 2000) + (2 * 2000 * (1 - 0.10))] + 100 * 10
  end

  it "dispatches the right actions" do
    rental = Rental.new(id: 1, car: car, start_date: "2017-12-8", end_date: "2017-12-10", distance: 100)
    payment_actions = rental.payment_actions.map(&:to_h)
    expect(payment_actions).to eq([
      {who: "driver", type: "debit", amount: 6600},
      {who: "owner", type: "credit", amount: 4620},
      {who: "insurance", type: "credit", amount: 990},
      {who: "assistance", type: "credit", amount: 300},
      {who: "drivy", type: "credit", amount: 690}
    ])
  end

  it "dispatches the right actions when options are integrated" do
    options = [
      { id: 1, rental_id: 1, type: "gps" },
      { id: 2, rental_id: 1, type: "baby_seat" },
      { id: 3, rental_id: 1, type: "additional_insurance" }
    ]
    rental = Rental.new(id: 1, car: car, start_date: "2017-12-8", end_date: "2017-12-10", distance: 100)
    rental.options = options.map{ |option_data| Option.new(**option_data.except(:rental_id).merge(rental:))}
    payment_actions = rental.payment_actions.map(&:to_h)
    expect(payment_actions).to eq([
      {who: "driver", type: "debit", amount: 11700},
      {who: "owner", type: "credit", amount: 6720},
      {who: "insurance", type: "credit", amount: 990},
      {who: "assistance", type: "credit", amount: 300},
      {who: "drivy", type: "credit", amount: 3690}
    ])
  end

  it "raises an ArgumentError if start_date is after end_date" do
    expect {
      Rental.new(id: 1, car: car, start_date: "2017-12-8", end_date: "2017-12-7", distance: 100)
    }.to raise_error(ArgumentError)
  end
end
