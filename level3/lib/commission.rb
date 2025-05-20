class Commission
  attr_reader :rental, :total, :insurance_fee, :assistance_fee, :drivy_fee
  COMMISSION = 0.3
  INSURANCE_SHARE = 0.5
  ROADSIDE_ASSISTANCE_PRICE_CENTS_PER_DAY = 100

  def initialize(rental:)
    @rental = rental
    @total = set_total
    @insurance_fee = set_insurance_fee
    @assistance_fee = set_assistance_fee
    @drivy_fee = set_drivy_fee
  end

  def set_total
    (rental.price * COMMISSION).to_i
  end

  def set_insurance_fee
    (total * INSURANCE_SHARE).to_i
  end

  def set_assistance_fee
    rental.duration * ROADSIDE_ASSISTANCE_PRICE_CENTS_PER_DAY
  end

  def set_drivy_fee
    total - insurance_fee - assistance_fee
  end

  def to_h
    {
      insurance_fee:,
      assistance_fee:,
      drivy_fee:
    }
  end
end
