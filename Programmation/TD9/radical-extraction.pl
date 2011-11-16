#!/usr/bin/env perl
use strict;
use warnings;
use utf8;
use Encode qw(encode decode);

open(ADJ, '<:utf8', "lefff-grace-utf8.txt") ;

while (<ADJ>) {
  if ($_ =~ m/Afpms$/ && $_ =~ m/(\w+)able\b/) { # Adj ending with -able
    if ($& !~ m/^dé|i(n|l|r|m)/) {               # no prefix
      print encode("utf8","Le radical de l'adjectif $& est $1\n") ;
    }
  }
}
