my @nums = (1 .. 10);

my @evens = grep { $_ % 2 == 0 } @nums;
my @squares = map { $_ * $_ } @nums;
my @sorted = sort { $b <=> $a } @nums;

my $adder = sub { my ($x, $y) = @_; $x + $y };
my $result = $adder->(2, 3);

my %seen;
my @unique = grep { !$seen{$_}++ } qw(a b a c b);
