#!/usr/bin/env perl
use strict;
use warnings;

###########################
# Match hyperlinks        #
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

my $length = 0;
while ( my ($k,$v) = each %links ) {
  $length = length($k) if $length < length($k) ;
}

$length += 1 ;


while ( my ($k,$v) = each %links ) {
   printf "%-${length}s -->  %-s\n", $k, $v if $v !~ /<.+?>/;;
}