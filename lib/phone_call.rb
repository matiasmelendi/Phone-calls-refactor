require_relative 'rates'

class PhoneCall

  attr_reader :datetime, :from_number, :to_number, :duration

  def initialize(datetime, orig_number, dest_number, duration)
    @datetime    = datetime
    @from_number = orig_number
    @to_number   = dest_number
    @duration    = duration
  end

  def year() datetime.year end

  def month() datetime.month end

  def continent() to_number.continent end

  def hour() datetime.hour end

  def same_country_code?
    from_number.country_code == to_number.country_code
  end

  def same_area_code?
    from_number.area_code == to_number.area_code
  end

end
