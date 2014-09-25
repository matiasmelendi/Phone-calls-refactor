require_relative 'country_code'

module CountryCodes

  def self.for_number(country_code_number)
    ALL.detect {|cc| cc.number == country_code_number }
  end

  ARGENTINA  = CountryCode.new 54, 'Argentina', 'South America'
  BRASIL     = CountryCode.new 55, 'Brasil', 'South America'
  ITALIA     = CountryCode.new 39, 'Italia', 'Europe'
  USA        = CountryCode.new 1, 'USA', 'North America'
  AUSTRALIA  = CountryCode.new 61, 'Australia', 'Oceania'

  ALL = [ARGENTINA, BRASIL, ITALIA, USA, AUSTRALIA]

end
