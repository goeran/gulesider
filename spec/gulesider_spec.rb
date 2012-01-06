#encoding: utf-8

require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Gulesider do
  describe "search" do
    it "is possible to search up a phone that belongs to a company" do
      result = Gulesider.search "90582054"
      result.first.company?.should be true
      result.first.person?.should be false
      result.first[:name].should eql "Linløkken Consulting"
      result.first[:phone].gsub(/\s/, "").should eql "90582054"
      result.first[:postal_code].should match /\d{4,}/
      result.first.should have_values_for [:street_name, :city]
    end
    
    it "can find multiple entries for a business number" do
      result = Gulesider.search 90966858
      result.length.should > 1
      result.first[:phone].gsub(/\s/, "").should eql "90966858"
      
      result.each do |entry|
        entry.company?.should be true
        entry.should have_values_for [:name, :phone, :street_name, :postal_code, :city]
      end
    end
    
    it "will remove special characters from data like \\r, \\n etc" do
      business_and_private_numbers do |number|
        result = Gulesider.search number
        result.each do |entry|
          entry[:phone].should_not match /\r|\n/
        end
      end
    end
    
    def business_and_private_numbers &block
      business_number = 90582054
      private_number = 90966858
      numbers = [business_number, private_number]
      numbers.each do |number|
        yield number
      end
    end
    
    it "will return an array with SearchResult hash as result" do
      business_and_private_numbers do |number|
        result = Gulesider.search number
        result.class.should be Array
        result.length.should > 0
        
        result.each do |item|
          item.class.should be SearchResult
        end
      end
    end
    
    it "is possible to search up a private person" do
      result = Gulesider.search "98260555"
      result.first.person?.should be true
      result.first.company?.should be false
      result.first[:name].should eql "Stian Eliassen"
      result.first[:phone].gsub(/\s/, "").should eql "98260555"
      result.first[:postal_code].should match /\d{4,}/
      result.first[:latitude].should match /^\d*\.\d*$/
      result.first[:longitude].should match /^\d*\.\d*$/
      result.first.should have_values_for [:street_name, :city]
    end
    
    it "can find multiple entries for a personal number" do
      result = Gulesider.search 46823378
      result.length.should > 1
      result.first[:phone].gsub(/\s/, "").should eql "46823378"
      
      result.each do |entry|
        entry.person?.should be true
        entry.should have_values_for [:name, :phone]
      end
    end
    
    it "is possible to use a number when search" do
      result = Gulesider.search 98260555
      result.first[:name].should eql "Stian Eliassen"
    end
  end
end