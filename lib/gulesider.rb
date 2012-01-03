require 'screen_scraper'

class Gulesider
  def self.search number
    return ScreenScraper.new.search number
  end
end