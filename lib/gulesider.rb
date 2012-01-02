require 'mechanize'
require 'screen_scraper'
require 'search_result'

class Gulesider
  def self.search number
    return ScreenScraper.new.search number
  end
end