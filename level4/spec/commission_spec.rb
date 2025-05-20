RSpec.describe Commission do
  let(:car) { Car.new(id: 1, price_per_day: 2000, price_per_km: 10) }
  let(:rental) { Rental.new(id: 1, car:, start_date: "2017-12-8", end_date: "2017-12-10", distance: 100) }

  it "calculates the commission correctly" do
    commission = Commission.new(rental:)
    expect(commission.to_h).to eq({
      insurance_fee: 990,
      assistance_fee: 300,
      drivy_fee: 690
    })
  end
end
