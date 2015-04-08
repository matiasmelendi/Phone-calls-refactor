require 'spec_helper'

describe "phone call rates" do

  describe "national rates" do
    before :each do
      @call = PhoneCall.new(nil,
        PhoneNumber.new(nil, 11, 54545454),
        PhoneNumber.new(nil, 343, 4563452), nil)
    end

    it "should identify the rate as national based on the call numbers" do
      Rates::NATIONAL.check_numbers(@call).should be true
    end

    it "should not indicate a call as national if the area codes are the same" do
     @call = PhoneCall.new(nil,
        PhoneNumber.new(nil, 11, 54545454),
        PhoneNumber.new(nil, 11, 56565656), nil)

      Rates::NATIONAL.check_numbers(@call).should be false
    end

    it "should get cost of a national rate for a call" do
      Rates.for_call(@call).cost_per_minute.should == 0.3
    end

  end

  describe "international rates" do

    before :each do
      @arg_number = PhoneNumber.new 54, 11, 54545454
      @bra_number = PhoneNumber.new 55, 48, 4545663452
      @ita_number = PhoneNumber.new 39, 2, 5234879
      @usa_number = PhoneNumber.new 1, 607, 6345254675
      @aus_number = PhoneNumber.new 61, 8, 6788834
      @call = PhoneCall.new nil, @arg_number, @bra_number, nil
    end

    it "should identify the rate as international based on the numbers" do
      Rates::SOUTH_AMERICA.check_numbers(@call).should be true
    end

    it "should get the cost for a call to Sudamerica" do
      Rates.for_call(@call).cost_per_minute.should == 0.5
    end

    it "should get the cost for a call to Europe or North America" do
      call_italy = PhoneCall.new nil, @arg_number, @ita_number, nil
      call_usa = PhoneCall.new nil, @arg_number, @usa_number, nil

      Rates.for_call(call_italy).cost_per_minute.should == 0.7
      Rates.for_call(call_usa).cost_per_minute.should == 0.7
    end

    it "should get the cost for a call to elsewhere" do
      call_aus = PhoneCall.new nil, @arg_number, @aus_number, nil

      Rates.for_call(call_aus).cost_per_minute.should == 1.5
    end
  end

  describe "local rates" do

    before :each do
      @local_1 = PhoneNumber.new nil, nil, 53468767
      @local_2 = PhoneNumber.new nil, nil, 43564588
      @call = PhoneCall.new nil, @local_1, @local_2, nil
    end

    it "should identify the rate as local based on the phone numbers" do
      Rates::LOCAL_8_TO_20.check_numbers(@call).should be true
    end

    it "should get the cost for a call during the hours 8 to 20" do
      call_1 = PhoneCall.new DateTime.new(2012, 02, 24, 11), @local_1, @local_2, nil
      call_2 = PhoneCall.new DateTime.new(2012, 02, 24, 8), @local_1, @local_2, nil
      call_3 = PhoneCall.new DateTime.new(2012, 02, 24, 20), @local_1, @local_2, nil

      [call_1, call_2, call_3].each do |call|
        Rates.for_call(call).cost_per_minute.should == 0.2
      end
    end

    it "should get the cost for a call during the hours from 21 to 7" do
      call_1 = PhoneCall.new DateTime.new(2012, 02, 24, 7), @local_1, @local_2, nil
      call_2 = PhoneCall.new DateTime.new(2012, 02, 24, 4), @local_1, @local_2, nil
      call_3 = PhoneCall.new DateTime.new(2012, 02, 24, 21), @local_1, @local_2, nil

      [call_1, call_2, call_3].each do |call|
        Rates.for_call(call).cost_per_minute.should == 0.1
      end
    end

    it "should get the cost for a call on sunday or saturday" do
      call_1 = PhoneCall.new DateTime.new(2012, 02, 25), @local_1, @local_2, nil
      call_2 = PhoneCall.new DateTime.new(2012, 02, 26), @local_1, @local_2, nil

      [call_1, call_2].each {|call| Rates.for_call(call).cost_per_minute.should == 0.1 }
    end

  end

end
