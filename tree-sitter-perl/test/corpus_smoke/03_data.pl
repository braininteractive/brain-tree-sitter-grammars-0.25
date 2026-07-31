my @list = (1, 2, 3);
my %config = (host => 'localhost', port => 8080);
my $aref = [4, 5, [6, 7]];
my $href = { nested => { deep => 1 } };

push @list, 4;
my $port = $config{port};
my $deep = $href->{nested}{deep};
my $second = $aref->[1];
my @slice = @list[0 .. 1];
my ($first) = @$aref;
