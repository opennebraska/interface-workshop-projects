#!/usr/bin/env ruby
require 'csv'

data = Hash.new
CSV.foreach('openstates-billactions.csv', :headers => true) do |row|
  sponsor = row[5].strip
  action = row[7]
  
  if not data[sponsor]
    data[sponsor] = Hash.new
    data[sponsor][:signed] = 0
  end
    
  if 'governor:signed' == action
    data[sponsor][:signed] += 1
  end
end

max_sponsor = 'Unknown'
max_signed = 0
min_sponsor = 'Unkown'
min_signed = 100

data.each do |sponsor, results|
  if results[:signed] > max_signed
    max_signed = results[:signed]
    max_sponsor = sponsor
  end
  
  if results[:signed] < min_signed
    min_signed = results[:signed]
    min_sponsor = sponsor
  end
end

puts "#{max_sponsor}: #{max_signed}"
puts "#{min_sponsor}: #{min_signed}"