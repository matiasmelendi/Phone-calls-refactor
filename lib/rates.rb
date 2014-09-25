require_relative 'rate'

module Rates

  def self.for_call(call)
    ALL.detect {|rate| rate.applies_to?(call) }
  end

  NATIONAL = NationalRate.new 0.3

  SOUTH_AMERICA = InternationalRate.new 0.5, lambda {|call|
    call.continent.eql?('South America')
  }

  EUROPE_NORTH_AMERICA = InternationalRate.new 0.7, lambda {|call|
    call.continent.eql?('Europe') || call.continent.eql?('North America')
  }

  REST_OF_WORLD = InternationalRate.new 1.5, lambda {|call|
    !(SOUTH_AMERICA.applies_to?(call) \
    || EUROPE_NORTH_AMERICA.applies_to?(call))
  }

  LOCAL_8_TO_20 = LocalRate.new 0.2, lambda {|call|
    !(LOCAL_WEEKEND.applies_to?(call)) \
    && call.hour.between?(8, 20)
  }

  LOCAL_21_TO_7 = LocalRate.new 0.1, lambda {|call|
    !LOCAL_8_TO_20.applies_to?(call)
  }

  LOCAL_WEEKEND = LocalRate.new 0.1, lambda {|call|
    call.datetime.saturday? || call.datetime.sunday?
  }

  ALL = [NATIONAL, SOUTH_AMERICA, EUROPE_NORTH_AMERICA, REST_OF_WORLD,
  LOCAL_8_TO_20, LOCAL_21_TO_7, LOCAL_WEEKEND]

end
