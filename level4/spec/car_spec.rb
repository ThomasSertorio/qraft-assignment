RSpec.describe Car do
  it "stores attributes correctly" do
    car = Car.new(id: 1, price_per_day: 2000, price_per_km: 10)

    expect(car.id).to eq(1)
    expect(car.price_per_day).to eq(2000)
    expect(car.price_per_km).to eq(10)
  end
end
