require_relative 'bill'
class Biller

  attr_reader :call_register

  def initialize(call_register)
    @call_register= call_register
  end

  def bill_for(customer, year, month)
    Bill.new(bill_cost_for(customer,year,month))
  end

  def cost(call)
    get_rate(call).cost_per_minute * call.duration
  end

  def fixed_bill_base_cost() 10 end

  def bill_cost_for(customer,year,month)
    call_register.calls_for(customer,year,month).inject(fixed_bill_base_cost){|rate,call| cost(call) + rate }
  end

  def get_rate(call)
    Rates.for_call(call)
  end

end