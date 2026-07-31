my $text = "The year 2026 and month 07";

if ($text =~ /(\d{4})/) {
    my $year = $1;
}

(my $cleaned = $text) =~ s/\s+/ /g;

$text =~ tr/a-z/A-Z/;

my @nums = $text =~ /(\d+)/g;

if ($text =~ m{month \s+ (\d+)}x) {
    print "month: $1\n";
}
