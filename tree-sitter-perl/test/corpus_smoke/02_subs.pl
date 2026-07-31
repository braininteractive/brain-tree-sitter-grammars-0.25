use strict;

sub add {
    my ($a, $b) = @_;
    return $a + $b;
}

sub greet {
    my %args = (greeting => 'hello', @_);
    return "$args{greeting}, $args{name}";
}

my $sum = add(1, 2);
print greet(name => 'dev'), "\n";
