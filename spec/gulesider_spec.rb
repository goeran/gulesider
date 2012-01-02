require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Gulesider do
  describe "search" do
    it "is possible to search up a phone that belongs to a company" do
      result = Gulesider.search "90582054"
      result[:name].should match "^Linl.kken Consulting$"
    end
    
    it "is possible to search up a private person" do
      result = Gulesider.search "98260555"
      result[:name].should eql "Stian Eliassen"
    end
  end
end