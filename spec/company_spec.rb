require 'spec_helper'

describe "company" do

  before :each do
    @company = Company.new
  end

  describe "billing" do

    before :each do
      @fulano = Customer.new "Fulano", PhoneNumber.new(54, 11, 56745920), @company
      @company.add_customer @fulano
    end

    it "should have a fixed base cost of $10" do
      @company.bill_for(@fulano, 2012, 02).fixed_bill_base_cost.should == 10
    end

    it "should calculate the bill for a customer (no calls at all)" do
      bill = @company.bill_for(@fulano, 2012, 02)

      bill.customer.should == @fulano
      bill.year.should == 2012
      bill.month.should == 02
      bill.amount.should == 10
    end

    it "should calculate the bill for a customer (no calls in this month)" do
      call_1 = PhoneCall.new DateTime.new(2012, 01, 27), @fulano.phone_number, nil, nil
      call_2 = PhoneCall.new DateTime.new(2012, 03, 01), @fulano.phone_number, nil, nil
      @company.add_call call_1
      @company.add_call call_2

      @company.bill_for(@fulano, 2012, 02).amount == 10
    end

    it "should calculate the bill for a customer (some calls in this month)" do
      call_1 = PhoneCall.new DateTime.new(2012, 01, 29), @fulano.phone_number, nil, nil
      call_2 = PhoneCall.new DateTime.new(2012, 02, 01, 19),
        @fulano.phone_number, PhoneNumber.new(54, 11, 59674511),
        4           # local, $0.2 * 4 = $0.8
      call_3 = PhoneCall.new DateTime.new(2012, 02, 12),
        @fulano.phone_number, PhoneNumber.new(54, 11, 45633345),
        22          # local, $0.1 * 22 = $2.2
      call_4 = PhoneCall.new DateTime.new(2012, 02, 01),
        @fulano.phone_number, PhoneNumber.new(61, 8, 980070),
        12          # international, $1.5 * 12 = $18

      [call_1, call_2, call_3, call_4].each {|call| @company.add_call call }

      @company.bill_for(@fulano, 2012, 02).amount.should == 31
    end

  end
end
