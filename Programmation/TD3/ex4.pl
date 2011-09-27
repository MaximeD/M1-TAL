#!/usr/bin/perl

# How many times do we have $value ?

use strict ;
use locale ;

my @tableau=(1,2,3,5,0,4) ;
my $tableau ;
my $value = 0 ;
my $total = 0 ;

foreach $tableau(@tableau)
{
    if ($value == $tableau)
    {
	$total = $total + 1 ;
    }
}

print "On trouve " . $total . " fois \"" . $value . "\" dans \@tableau\n" ;
