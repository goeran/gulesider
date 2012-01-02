Gem::Specification.new do |s|
  s.name = %q{gulesider}
  s.version = "0.1.0"
  s.date = %q{2012-01-02}
  s.summary = %q{Screen scraper for gulesider.no. A globa Norwegian phone book}
  s.files = [
    "lib/search_result.rb",
    "lib/screen_scraper.rb",
    "lib/gulesider.rb"
  ]
  s.require_paths = ["lib"]
  s.add_dependency('mechanize', '>= 2.1')
  s.author = "Goeran Hansen"
  s.email = "mail@goeran.no"
  s.homepage = "http://github.com/goeran/gulesider"
end