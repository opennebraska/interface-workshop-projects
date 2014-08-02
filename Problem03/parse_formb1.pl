use Modern::Perl;
use Text::CSV;

my $file = "nadc_data-master/formb1.txt";

my $total;
my $csv = Text::CSV->new ( { binary => 1 } )  # should set binary attribute.
  or die "Cannot use CSV: ".Text::CSV->error_diag ();
open my $fh, "<:encoding(utf8)", $file or die "$file: $!";
while ( my $row = $csv->getline( $fh ) ) {
  s/[\r\n]//g for @$row;
  s/[^ -~]//g for @$row;
  s/  +/ /g for @$row;
  my @row = @$row;

  # OK, we finally have "clean" data to work with now...
  
  my $date = $row[9];     # "Date received"
  my $amount = $row[46];  # "Field 20" - "Cash receipts this period"
  #next unless ($who =~ /conagra/i);
  # next unless ($date =~ /2011/);
next unless ($amount);
  $total += $amount;
  say $amount;

#  say join "|", @row;
}
$csv->eof or $csv->error_diag();
close $fh;

say "Total: $total";





