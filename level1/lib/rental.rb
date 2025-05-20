require "date"

class Rental
  attr_reader :id, :car, :start_date, :end_date, :distance

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
    time_component = duration * car.price_per_day
    distance_component = distance * car.price_per_km
    time_component + distance_component
  end
end
