#!/usr/bin/env perl
use strict ;
use warnings ;

open(BAD, '<', 'mauvaiseClasse.txt') ;
open(GOOD, '>', 'bonneClasse.txt') ;

while (<BAD>)
{
    $_ =~ s/[- ](\w+?)/\u$1/g ;
    print (GOOD ucfirst($_)) ;
}
