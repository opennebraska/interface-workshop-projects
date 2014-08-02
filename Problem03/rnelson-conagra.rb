#!/usr/bin/env ruby
require 'csv'
COMMITTEE_NAME = 'CONAGRA FOODS, INC.'

# Find the committee ID
committee_id = ''
CSV.foreach('nadc_data-master/formb7.txt', :headers => true, :col_sep => '|') do |row|
  if COMMITTEE_NAME == row[0]
    committee_id = row[1]
    break
  end
end

# Deal with quoting
quote_chars = %w(" | ~ ^ & *)
begin
  data = CSV.read('nadc_data-master/formb2a.txt', :headers => true, :col_sep => '|', :quote_char => quote_chars.shift)
rescue CSV::MalformedCSVError
  quote_chars.empty? ? raise : retry 
end

# Find an answer
contributions = 0.0
data.each do |row|
  contributions += row[4].to_f if row[2] == committee_id and row[3].end_with?('2011')
end

# Answer
puts "#{COMMITTEE_NAME} contributed $#{contributions} in 2011"
