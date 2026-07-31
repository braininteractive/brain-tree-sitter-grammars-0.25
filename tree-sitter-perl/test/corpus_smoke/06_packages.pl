package Shape;
use strict;

sub new {
    my ($class, %args) = @_;
    my $self = { name => $args{name} // 'shape' };
    return bless $self, $class;
}

sub name { $_[0]->{name} }

package Circle;
use parent -norequire, 'Shape';

sub area {
    my ($self) = @_;
    return 3.14159 * $self->{radius} ** 2;
}

package main;

my $c = Circle->new(name => 'c1');
print $c->name, "\n";
