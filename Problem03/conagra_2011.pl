use Modern::Perl;

my $total;

open my $in, "<", "nadc_data-master/formb2a.txt" or die;
while (<$in>) {
  chomp;
  my @row = split /\|/;
  my $date = $row[3];
  my $amount = $row[4];
  my $who = $row[7];
  next unless ($who =~ /conagra/i);
  next unless ($date =~ /2011/);
  $total += $amount;
  say;
}

say "Total: $total";

