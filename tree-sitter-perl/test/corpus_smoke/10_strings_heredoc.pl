my $name = 'perl';
my $interp = "double $name @{[ 1 + 2 ]}";
my $literal = 'single $name';
my $q = q(paren quoted);
my $qq = qq{brace "quoted" $name};
my @words = qw(alpha beta gamma);

my $doc = <<"END";
heredoc with $name
interpolation
END

my $raw = <<'RAW';
no $interpolation here
RAW

print length($doc . $raw . $q . $qq), "\n";
