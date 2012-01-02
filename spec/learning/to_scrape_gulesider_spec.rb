require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe "learning to scrape gulesider.no" do
  before :each do
    @gulesider = "http://www.gulesider.no/finn:"
    @agent = Mechanize.new
  end
  
  it "should be possible to scrape data from page?" do
    result = @agent.get @gulesider + "90582054"
    list = result.search "#result-list"
    first_hit = result.search "div.hit"
    phone = first_hit.search("li.tel:first-child").text;
    name = first_hit.search("div.header").search("a").text
    street_name = first_hit.search("span.street-address").text
    postal_code = first_hit.search("span.postal-code").text
    city = first_hit.search("span.locality").text
    puts "Phone: " + phone
    puts "Name: " + name.to_s
    puts "Adresse: " + street_name
    puts "Postnummer: " + postal_code
    puts "By: " + city
  end
  
  it "should be possible to scrape data for a private person?" do
    result = @agent.get @gulesider + "98260555"
    #http://www.gulesider.no/person/profil/stian+eliassen/0000808649400000000
    #puts @agent.current_page.canonical_uri
    vcard = result.search "div.vcard"
    given_name = vcard.search("span.given-name").text
    family_name = vcard.search("span.family-name").text
    name = "#{given_name} #{family_name}"
    address = vcard.search "span.adr"
    street_name = address.search("span.street-address").text
    postal_code = address.search("span.postal-code").text
    city = address.search("span.locality").text
    latitude = address.search("span.latitude").text
    longitude = address.search("span.longitude").text
    puts "Name: " + name
    puts "Adresse: " + street_name
    puts "Postnummer: " + postal_code
    puts "By: " + city
    puts "Lat/Long: #{latitude}, #{longitude}"
  end
end