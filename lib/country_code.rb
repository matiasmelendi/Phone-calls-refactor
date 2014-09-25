class CountryCode

  attr_reader :number, :country, :continent

  def initialize(number, country, continent)
    @number    = number
    @country   = country
    @continent = continent
  end

  def ==(another_cc) number == another_cc.number end

end
