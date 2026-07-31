my $n = 5;

if ($n < 0) {
    print "negative\n";
} elsif ($n == 0) {
    print "zero\n";
} else {
    print "positive\n";
}

for my $i (1 .. 10) {
    next if $i % 2;
    last if $i > 8;
    print $i;
}

my $j = 3;
while ($j > 0) { $j--; }
until ($j >= 2) { $j++; }

print "big\n" unless $n < 10;
print "ok\n" if $n;
