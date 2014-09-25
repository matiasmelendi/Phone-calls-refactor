describe "phone numbers" do

  it "should know country of the code" do
    PhoneNumber.new(54, 11, 57575757).country.should == 'Argentina'
    PhoneNumber.new(55, 48, 5746577787).country.should == 'Brasil'
    PhoneNumber.new(39, 2, 578847392).country.should == 'Italia'
    PhoneNumber.new(1, 609, 4386974).country.should == 'USA'
    PhoneNumber.new(61, 8, 6788834).country.should == 'Australia'
  end

  it "should know continent of the code" do
    PhoneNumber.new(54, 11, 57575757).continent.should == 'South America'
    PhoneNumber.new(55, 48, 5746577787).continent.should == 'South America'
    PhoneNumber.new(39, 2, 578847392).continent.should == 'Europe'
    PhoneNumber.new(1, 609, 4386974).continent.should == 'North America'
    PhoneNumber.new(61, 8, 6788834).continent.should == 'Oceania'
  end

end
