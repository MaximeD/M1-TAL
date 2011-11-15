#!/usr/bin/env perl

use strict;
use warnings;

####################################################
# Use this to find words matching double consonant #
# in file					   #
####################################################

if (!$ARGV[0]) {
  open(FILE, '<', "conteGrimm.txt") or die ; # test file
}
else {
  open(FILE, '<', $ARGV[0]) or die ;
}


my @double_consonant ;
my $count ;

while (<FILE>) {
  if ($_ =~ m/\w+([^aeiouy])\1\w+/gi) {
    @double_consonant = (@double_consonant, $&) ;
    $count ++ ;
  }
}

print "Found the following ($count words):\n" ;
print "\"" . join("\", \"", @double_consonant) . "\"\n";

close(FILE) ;

