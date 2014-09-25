require 'rspec'

describe 'Rates for phone calls' do

  before :each do
    @company= Company.new
    @customer_national= Customer.new 'Memo', (PhoneNumber.new 54, 11, 54545454), @company
    @customer_national_2= Customer.new 'Memo', (PhoneNumber.new 54, 222, 54545455), @company
    @customer_international= Customer.new 'Memo', (PhoneNumber.new 1, 343, 4565675), @company
    @customer_local= Customer.new 'Memo', (PhoneNumber.new 54, 11, 45327854), @company
  end

  it "should get the cost for a national call" do

    @customer_national.call_to(@customer_national_2,5)
    bill=@company.bill_for(@customer_national,2014,9)
    bill.amount.should be 11.5         # (5* 0.3) + 10
  end

  it "should get the cost for an international call" do

    @customer_national.call_to(@customer_international,10)
    bill=@company.bill_for(@customer_national,2014,9)
    bill.amount.should be 17.0         # (10* 0.7) + 10
  end

  it "should get the cost for a local call" do

    @customer_national.call_to(@customer_local,21)
    bill=@company.bill_for(@customer_national,2014,9)
    bill.amount.should be 14.2         # (0.2* 21) + 10
  end

end