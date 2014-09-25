require_relative 'country_codes'

class PhoneNumber

  attr_reader :country_code, :area_code, :number

  def initialize(cc_number, area_code, number)
    @country_code = CountryCodes.for_number cc_number
    @area_code = area_code
    @number = number
  end

  def country() country_code.country end

  def continent() country_code.continent end

  def ==(another_number)
    country_code == another_number.country_code \
    && area_code == another_number.area_code \
    && number == another_number.number
  end

end
