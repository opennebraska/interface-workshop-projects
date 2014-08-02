use Modern::Perl;

my %totals;
open my $in, "<", "nadc_data-master/formb1.txt";
while (<$in>) {
  chomp;
  my @row = split /\|/;
  my $who =    $row[0];   # "Committee Name"
  my $date =   $row[9];   # "Date received"
  my $amount = $row[46];  # "Field 20" - "Cash receipts this period"
  # next unless ($who =~ /conagra/i);
  # next unless ($date =~ /2011/);
  $totals{$who} += $amount if $amount;
}

foreach my $who ( reverse sort by_total keys %totals) {
  my $amount = sprintf("%.2f", $totals{$who});
  printf "%10s - %s\n", $amount, $who;
}

sub by_total {
  $totals{$a} <=> $totals{$b}
}







