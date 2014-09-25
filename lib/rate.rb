class Rate

  attr_reader :cost_per_minute, :condition

  def initialize(cost_per_min, condition)
    @cost_per_minute = cost_per_min
    @condition       = condition
  end

  def applies_to?(phone_call)
    check_numbers(phone_call) && condition.call(phone_call)
  end

end

class NationalRate < Rate

  def initialize(cost_per_min)
    super cost_per_min, lambda {|call| true }
  end

  def check_numbers(phone_call)
    phone_call.same_country_code? && !(phone_call.same_area_code?)
  end

end

class InternationalRate < Rate

  def check_numbers(phone_call)
    !phone_call.same_country_code?
  end

end

class LocalRate < Rate

  def check_numbers(phone_call)
    phone_call.same_country_code? && phone_call.same_area_code?
  end

end
