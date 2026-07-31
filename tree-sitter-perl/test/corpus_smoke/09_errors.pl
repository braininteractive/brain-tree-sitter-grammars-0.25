use strict;

eval {
    die { code => 42, msg => "structured error" };
};
if (my $err = $@) {
    print ref($err) eq 'HASH' ? $err->{msg} : $err, "\n";
}

local $SIG{__WARN__} = sub { print "warned: $_[0]" };
warn "advisory\n";

sub risky {
    my ($n) = @_;
    die "negative\n" if $n < 0;
    return sqrt($n);
}
