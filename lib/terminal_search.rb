# encoding: utf-8
require 'gulesider'

puts "Søker på gulesider.no"
result = Gulesider.search("#{ARGV[0]}")
puts ""
puts "#{result[:name]}"
address = "#{result[:street_name]}, #{result[:postal_code]} #{result[:city]}"
puts address if address != ",  "