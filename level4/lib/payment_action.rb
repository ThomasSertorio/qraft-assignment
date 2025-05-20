class PaymentAction
  attr_reader :who, :type, :amount

  ACTORS = [
    DRIVER = "driver",
    OWNER = "owner",
    INSURANCE = "insurance",
    ASSISTANCE = "assistance",
    DRIVY = "drivy"
  ].freeze

  NATURES = [
    CREDIT = "credit",
    DEBIT = "debit"
  ].freeze

  def initialize(who:, type:, amount:)
    @who = who
    @type = type
    @amount = amount
  end

  def to_h
    {
      who:,
      type:,
      amount:
    }
  end
end
