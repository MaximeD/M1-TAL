#!/usr/bin/perl

use strict ;
use locale ;

my @tableau=(1,2,3,8,5,8,0,4) ;
my $tableau ;
my $value = 0 ;
my $max = 0 ;
my $i ;
my @place = () ;

# maximum
foreach $tableau(@tableau)
{
    if ($max < $tableau)
    {
	$max = $tableau ;
    }
}

print "La valeur max de \@tableau est $max\n" ;

# where
for ($i=0; $i < 8; $i++){
    if ($max == $tableau[$i])
    {
	@place = (@place, $i + 1) ;
    }
}

print "Les valeurs maximales de \@tableau sont aux places @place\n" ;
