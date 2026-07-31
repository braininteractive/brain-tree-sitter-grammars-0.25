use strict;

open(my $fh, '<', '/etc/hosts') or die "cannot open: $!";
while (my $line = <$fh>) {
    chomp $line;
    next if $line =~ /^#/;
    my @fields = split /\s+/, $line;
    print scalar(@fields), "\n";
}
close $fh;

open(my $out, '>>', '/tmp/log.txt') or warn "no log: $!";
print {$out} "entry\n";
close $out;
