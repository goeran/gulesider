# encoding: utf-8
require 'gulesider'

puts "Søker på gulesider.no"

query = ARGV[0]
result = Gulesider.search("#{query}")

puts ""
puts "#{result.length} resultat#{result.length > 1 ? "er" : ""}"
puts ""

result.each do |entry|
  puts "\tNavn: " + entry[:name]
  puts "\tNummer: " + entry[:phone]
  address = "\t#{entry[:street_name]}, #{entry[:postal_code]} #{entry[:city]}"
  puts address if !entry[:street_name].empty? and address != ", "
  puts ""
end
