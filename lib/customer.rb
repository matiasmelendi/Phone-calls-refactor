require_relative 'phone_call'
class Customer

  attr_reader :name, :phone_number, :company

  def initialize(name, phone_number,company)
    @name         = name
    @phone_number = phone_number
    @company        = company
  end

  def call_to(another_customer,duration)
    company.add_call(
                PhoneCall.new(
                (DateTime.now),self.phone_number,
                another_customer.phone_number,duration))

  end

end
