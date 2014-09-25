require_relative 'biller'
require_relative 'call_register'

class Company

  attr_reader :customers
  attr_accessor :call_register

  def initialize
    @customers = []
    @call_register= CallRegister.new
  end

  def add_customer(customer)
    customers << customer
  end

  def add_call(call)
    call_register.add_call(call)
  end

  def bill_for(customer, year, month)
    (Biller.new(call_register)).bill_for(customer, year, month)
  end

  def search_customer_by_phone_number(number)
    customers.detect(lambda{raise Exception.new('El usuario no existe')}) {|customer| customer.phone_number == number }
  end

  def calls_from_month(customer,year, month)
    call_register.calls_for(customer,year,month)
  end

end
