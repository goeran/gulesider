require 'mechanize'
require 'search_result'

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
    search_result = []
    
    vcard = @result.search "div.vcard"
    profile_info = vcard.search "div.profile-info"
    
    profile_info.search("p").each do |p|
      name = vcard.search("span.given-name").text + " " + vcard.search("span.family-name").text
      phone = p.search("span.tel > a").text.strip
      address = p.search("span.adr")
      street_name = address.search("span.street-address").text
      postal_code = address.search("span.postal-code").text
      city = address.search("span.locality").text
      lat = address.search("span.latitude").text
      long = address.search("span.longitude").text

      if phone != ""
        search_result.push SearchResult.new({
          :person => true,
          :name => name,
          :phone => phone,
          :street_name => street_name,
          :postal_code => postal_code,
          :city => city,
          :latitude => lat,
          :longitude => long
        })
      end
    end
    
    return search_result
  end
  
  def scraped_company_data
    search_result = []
    list = @result.search "#result-list"
    hits = list.search("div.company-hit")
    
    hits.each do |hit|
      search_result.push SearchResult.new({
        :company => true,
        :name => hit.search("div.header").search("a").text,
        :phone => hit.search("li.tel:first-child").text,
        :street_name => hit.search("span.street-address").text,
        :postal_code => hit.search("span.postal-code").text,
        :city => hit.search("span.locality").text
      })
    end
    
    return search_result
  end
end