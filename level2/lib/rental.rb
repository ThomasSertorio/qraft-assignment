require "date"

class Rental
  attr_reader :id, :car, :start_date, :end_date, :distance
  DISCOUNT_RULES = [
    { from: 1, to: 1, discount: 0.0 },
    { from: 2, to: 4, discount: 0.10 },
    { from: 5, to: 10, discount: 0.30 },
    { from: 11, to: Float::INFINITY, discount: 0.50 }
  ]

  def initialize(id:, car:, start_date:, end_date:, distance:)
    @id = id
    @car = car
    @start_date = Date.parse(start_date)
    @end_date = Date.parse(end_date)
    @distance = distance
  end

  def duration
    (@end_date - @start_date).to_i + 1
  end

  def price
    time_component + distance_component
  end

  def time_component
    DISCOUNT_RULES.sum do |rule|
      days_in_band = [0, [duration, rule[:to]].min - rule[:from] + 1].max
      days_in_band * car.price_per_day * (1 - rule[:discount])
    end.to_i
  end

  def distance_component
    distance * car.price_per_km
  end
end
