require 'CSV'

winning_senators = {}
bills_csv = 'openstates-billactions.csv'

CSV.foreach(bills_csv) do |row|
  # puts row.inspect # useful for seeing the raw output

  sponsor = "#{row[5].match(/\S+/)}"
  last_action = row[7]
  signed = last_action == 'governor:signed'

  if signed
    if winning_senators.has_key? sponsor
      winning_senators[sponsor] += 1
    else
      winning_senators[sponsor] = 1
    end
  end
end

winner = winning_senators.sort_by {|k,v| v}.reverse.first

puts "The winning-est senator was #{winner[0]} with #{winner[1]} bills passed"