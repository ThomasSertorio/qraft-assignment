class Car
  attr_reader :id, :price_per_day, :price_per_km

  def initialize(id:, price_per_day:, price_per_km:)
    @id = id
    @price_per_day = price_per_day
    @price_per_km = price_per_km

    raise ArgumentError, "price_per_day must be > to roadside assistance per day (#{Commission::ROADSIDE_ASSISTANCE_PRICE_CENTS_PER_DAY})" if price_per_day <= Commission::ROADSIDE_ASSISTANCE_PRICE_CENTS_PER_DAY
    raise ArgumentError, "price_per_km must be >= 0)" if price_per_km < 0
  end
end
