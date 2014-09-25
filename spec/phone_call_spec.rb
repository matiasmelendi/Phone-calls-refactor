describe "phone calls" do

  it "should get false because the area codes are different" do
    call = PhoneCall.new(nil,
      PhoneNumber.new(nil, 11, 54545454),
      PhoneNumber.new(nil, 343, 4565675), 5)

    call.same_area_code?.should be false
  end

  it "should get false because it's an international call" do
    call = PhoneCall.new(nil,
      PhoneNumber.new(54, 11, 54545454),
      PhoneNumber.new(1, 343, 4565675), 10)

    (call.same_country_code? && call.same_area_code?).should be false
  end

  it "should get true because it's a local call" do
    call = PhoneCall.new(DateTime.new(2012, 02, 25),
      PhoneNumber.new(54, 11, 54545454),
      PhoneNumber.new(54, 11, 45327854), 21)

   (call.same_country_code? && call.same_area_code?).should be true
  end

end
