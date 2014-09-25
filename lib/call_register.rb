class CallRegister

  attr_accessor :calls

  def initialize
    @calls=[]
  end

  def add_call(call)
    calls << call
  end

  def calls_for(customer,year, month)
    calls.select {|call| call.year == year && call.month == month &&
        call.from_number == customer.phone_number}
  end

end