require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Gulesider do
  describe "search" do
    it "is possible to search up a phone that belongs to a company" do
      result = Gulesider.search "90582054"
      result.company?.should be true
      result.person?.should be false
      result[:name].should match /^Linl.kken Consulting$/
      result[:phone].should_not be nil
      result[:street_name].should_not be nil
      result[:postal_code].should match /\d{4,}/
      result[:city].should_not be nil
    end
    
    it "is possible to search up a private person" do
      result = Gulesider.search "98260555"
      result.person?.should be true
      result.company?.should be false
      result[:name].should eql "Stian Eliassen"
      result[:phone].should_not be nil
      result[:street_name].should_not be nil
      result[:postal_code].should match /\d{4,}/
      result[:city].should_not be nil
      result[:latitude].should_not be nil
      result[:longitude].should_not be nil
    end
    
    it "is possible to use a number when search" do
      result = Gulesider.search 98260555
      result[:name].should eql "Stian Eliassen"
    end
  end
end