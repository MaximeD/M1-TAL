#!/usr/bin/env perl
use strict;
use warnings;
use utf8;
binmode(STDOUT, 'utf8');


open(FILE, '<:utf8', "outGP_CONLL.out");

while (<FILE>) {
  if ($_ eq "\n") {
    print "\n";
  }
  else {
    my @infos = (split("\t", $_)) ;
    print $infos[1] . "\t";
    print $infos[3] . "\t";
    print $infos[5] . "\n";
  }
}
close(FILE);

