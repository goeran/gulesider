require 'mechanize'

class Gulesider
  def self.search number 
    gulesider = "http://www.gulesider.no/finn:"
    agent = Mechanize.new
    result = agent.get gulesider + number
    
    if agent.current_page.canonical_uri.to_s.include? "http://www.gulesider.no/person" 
      vcard = result.search "div.vcard"
      address = vcard.search "span.adr"
      return {
        :name => vcard.search("span.given-name").text + " " + vcard.search("span.family-name").text,
        :phone => number,
        :street_name => address.search("span.street-address").text,
        :postal_code => address.search("span.postal-code").text,
        :city => address.search("span.locality").text,
        :latitude => address.search("span.latitude").text,
        :longitude => address.search("span.longitude").text
      }
    else
      list = result.search "#result-list"
      first_hit = result.search "div.hit"
      
      return {
        :name => first_hit.search("div.header").search("a").text,
        :phone => first_hit.search("li.tel:first-child").text,
        :street_name => first_hit.search("span.street-address").text,
        :postal_code => first_hit.search("span.postal-code").text,
        :city => first_hit.search("span.locality").text
      }
    end
  end
end