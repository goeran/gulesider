require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe "learning to scrape gulesider.no" do
  it "should be able to scrape data from page?" do
    gulesider = "http://www.gulesider.no/finn:"
    agent = Mechanize.new
    result = agent.get gulesider + "90582054"
    list = result.search "#result-list"
    first_hit = result.search "div.hit"
    phone = first_hit.search("li.tel:first-child").text;
    name = first_hit.search("div.header").search("a").text
    puts "Phone: " + phone
    puts "Name: " + name.to_s
  end
end