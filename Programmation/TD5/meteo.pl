#!/usr/bin/env perl
use strict ;
use warnings ;

open(METEO, '<', 'temperatures.csv') ;

my %meteo ;
while (<METEO>) {
  if (/(\w+) (\d+) (\d+\.\d+)/) {
    $meteo{"$1"} = "$3" ;
  }
}

my @sorted_keys = sort { $meteo{$b} <=> $meteo{$a} } keys %meteo;
print "La ville la plus chaude est $sorted_keys[0] avec $meteo{$sorted_keys[0]}°C de moyenne\n";
print "À l'inverse, la ville la plus froide est $sorted_keys[-1] avec $meteo{$sorted_keys[-1]}°C de moyenne\n";

