#!/usr/bin/env perl
use strict;
use warnings;

###########################
# Match hyperlinks	  #
# and the associated text #
###########################

if (!$ARGV[0]) {
  open(FILE, '<', "17640") ;
}
else {
  open(FILE, '<', $ARGV[0]) ;
}

my %links ;

while (<FILE>) {
  if ($_ =~ m/<a.+?href="(.+?)".+?>(.+?)<\/a>/gi) {
    $links{"$1"} = $2 ;
  }
}

while ( my ($k,$v) = each %links ) {
    print "$k \t\t--> \t$v\n" if $v !~ /<.+?>/; # not a description ? bye !
}

