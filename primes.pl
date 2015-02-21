#!/usr/bin/perl -w
# primes.pl

use strict;

print "Enter a number you would like to calculate primes to: ";
my $ctr = my $num = <STDIN>;
my @numsList = (2 .. $num);

for(my $p = 2;($p*$p) <= $num;$p++) {
	for(my $i = $p;$i<$ctr-1;$i++) {
		if(($numsList[$i] % $p) == 0) {
			splice(@numsList,$i,1);
			$ctr--;
		}
	}
}
print "Prime numbers from 2 to $num";
print "@numsList \n";
