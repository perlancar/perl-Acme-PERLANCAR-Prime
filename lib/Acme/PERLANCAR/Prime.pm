package Acme::PERLANCAR::Prime;

# DATE
# DIST
# VERSION

use 5.010001;
use integer;
use strict;
use warnings;

use Exporter qw(import);
our @EXPORT_OK = qw(primes);

my @primes = (2);

sub _empty_cache {
    @primes = (2);
}

sub _is_prime {
    my $num = shift;
    my $sqrt = $num**0.5;
    for my $i (0..$#primes) {
        my $fact = $primes[$i];
        last if $fact > $sqrt;
        return 0 if $num % $fact == 0;
    }
    1;
}

sub primes {
    my ($base, $num);

    if (@_ > 1) {
        ($base, $num) = @_;
    } else {
        $base = 1;
        $num = $_[0];
    }

    my @res;
    my $i = $base;
    $i = 2 if $i < 2;

    # first, fill with precomputed primes
    my $k = -1;
    for my $j (0..$#primes) {
        my $p = $primes[$j];
        if ($p >= $i && $p <= $num) {
            push @res, $p;
            $i = $p + 1;
            $k = $j;
        }
    }

    while ($i <= $num) {
        if (_is_prime($i)) {
            push @primes, $i;
            push @res, $i;
        }
        $i++;
        $i++ if $i % 2 == 0; # quick skip even numbers
    }
    @res;
}

1;
# ABSTRACT: Return prime numbers

=head1 DESCRIPTION

This distribution is created for testing only.


=head1 FUNCTIONS

=head2 primes([ $base, ] $num) => list

Return prime numbers (from C<$base> if specified) that are less than or equal to
C<$num>.
