require 'screen_scraper'

class Gulesider
  def self.search number
    return [] if number == nil or number == ""
    return ScreenScraper.new.search number
  end
end