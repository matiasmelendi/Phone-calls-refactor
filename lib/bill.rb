class Bill

  attr_reader :amount
  attr_reader :customer
  attr_reader :year
  attr_reader :month

  def initialize(amount, customer, year, month)
    @amount = amount
    @customer = customer
    @year = year
    @month = month
  end

  def fixed_bill_base_cost
    10
  end

end
