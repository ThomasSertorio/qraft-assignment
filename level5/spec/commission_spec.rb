RSpec.describe Commission do
  
  it "calculates the commission correctly" do
    car = Car.new(id: 1, price_per_day: 2000, price_per_km: 10)
    rental = Rental.new(id: 1, car:, start_date: "2017-12-8", end_date: "2017-12-10", distance: 100)
    commission = Commission.new(rental:)
    expect(commission.to_h).to eq({
      insurance_fee: 990,
      assistance_fee: 300,
      drivy_fee: 690
    })
  end

  it "raises an error if rental is too cheap" do
    car = Car.new(id: 1, price_per_day: (Commission::ROADSIDE_ASSISTANCE_PRICE_CENTS_PER_DAY + 1), price_per_km: 10)
    rental = Rental.new(id: 1, car: car, start_date: "2017-12-8", end_date: "2017-12-10", distance: 100)
    expect {
      Commission.new(rental:)
    }.to raise_error(ArgumentError)
  end
end
