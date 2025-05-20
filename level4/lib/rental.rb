require "date"
require_relative "commission"
require_relative "payment_action"

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

  def commission
    @_commission ||= Commission.new(rental: self)
  end

  def payment_actions
    [
      PaymentAction.new(
        who: PaymentAction::DRIVER,
        type: PaymentAction::DEBIT,
        amount: price
      ),
      PaymentAction.new(
        who: PaymentAction::OWNER,
        type: PaymentAction::CREDIT,
        amount: price - commission.total
      ),
      PaymentAction.new(
        who: PaymentAction::INSURANCE,
        type: PaymentAction::CREDIT,
        amount: commission.insurance_fee
      ),
      PaymentAction.new(
        who: PaymentAction::ASSISTANCE,
        type: PaymentAction::CREDIT,
        amount: commission.assistance_fee
      ),
      PaymentAction.new(
        who: PaymentAction::DRIVY,
        type: PaymentAction::CREDIT,
        amount: commission.drivy_fee
      )
    ]
  end
end
