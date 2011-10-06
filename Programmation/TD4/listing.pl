#!/usr/bin/perl
use warnings ;
use strict ;

my ($file, $listing) ;

print "Which *.pl file do you want to open ?\n" ;
chomp($file = <STDIN>) ;
if ($file =~ m/\.pl$/) {
  open(ORIGINAL, '<', $file) or die ;

  print "Where do you want to store the listing ?\n" ;
  chomp($listing = <STDIN>) ;
  open (LISTING, '>', $listing) ;
  while (<ORIGINAL>) {
    print (LISTING "$. $_") ;
  }
}

else {
  print "This is not a perl file !\n" ;
}
