class Option
  attr_reader :id, :rental, :type
  TYPES = {
    "gps" => { price_per_day: 500, target: PaymentAction::OWNER },
    "baby_seat" => { price_per_day: 200, target: PaymentAction::OWNER },
    "additional_insurance" => { price_per_day: 1000, target: PaymentAction::DRIVY }
  }.freeze

  def initialize(id:, rental:, type:)
    @id = id
    @rental = rental
    @type = type

    raise ArgumentError, "type must be among #{TYPES.keys}" if TYPES[type].nil?
  end

  def price_per_day
    TYPES[type][:price_per_day]
  end

  def target
    TYPES[type][:target]
  end

  def price
    price_per_day * rental.duration
  end
end
