class ScreenScraper
  def initialize
    @gulesider = "http://www.gulesider.no/finn:"
    @agent = Mechanize.new
  end
  
  def search number
    search_webpage_for number
    
    return scraped_person_data if number_belongs_to_a_person?
    return scraped_company_data
  end
  
  private
  def search_webpage_for number
    @result = @agent.get "#{@gulesider}#{number}"
  end
  
  def number_belongs_to_a_person?
    @agent.current_page.canonical_uri.to_s.include? "http://www.gulesider.no/person"
  end
  
  def scraped_person_data
    vcard = @result.search "div.vcard"
    address = vcard.search("span.adr").first
    
    return SearchResult.new({
      :person => true,
      :name => vcard.search("span.given-name").text + " " + vcard.search("span.family-name").text,
      :phone => vcard.search("li.tel:first-child").text,
      :street_name => address.search("span.street-address").text,
      :postal_code => address.search("span.postal-code").text,
      :city => address.search("span.locality").text,
      :latitude => address.search("span.latitude").text,
      :longitude => address.search("span.longitude").text
    })
  end
  
  def scraped_company_data
    list = @result.search "#result-list"
    first_hit = list.search "div.hit"
    
    return SearchResult.new({
      :company => true,
      :name => first_hit.search("div.header").search("a").text,
      :phone => first_hit.search("li.tel:first-child").text,
      :street_name => first_hit.search("span.street-address").text,
      :postal_code => first_hit.search("span.postal-code").text,
      :city => first_hit.search("span.locality").text
    })
  end
end