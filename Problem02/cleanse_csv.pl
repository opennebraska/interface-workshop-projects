use Modern::Perl;
use Text::CSV;
 
my @rows;
my $csv = Text::CSV->new ( { binary => 1 } )  # should set binary attribute.
  or die "Cannot use CSV: ".Text::CSV->error_diag ();
open my $fh, "<:encoding(utf8)", "openstates-billactions.csv" or die "openstates-billactions.csv: $!";
while ( my $row = $csv->getline( $fh ) ) {
  s/[\r\n]//g for @$row;
  s/[^ -~]//g for @$row;
  s/  +/ /g for @$row;
  say join "|", @$row;
}
$csv->eof or $csv->error_diag();
close $fh;



__END__

$VAR1 = [
          '102S1',
          'LR 9',
          'Congratulate Dustin J. Dunlap for earning the rank of Eagle Scout',
          'resolution',
          'primary',
          '
                Janssen',
          'NEL000015',
          'other'
        ];



