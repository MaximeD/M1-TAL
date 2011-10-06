#!/usr/bin/env perl
use strict ;
use warnings ;

my ($file, $line) ;

print "Enter a file name :\n" ;
chomp($file = <STDIN>) ;
open (FILE, ">>$file") ;

print "\nType the lines you want to add to \"$file\"\n" ;
print "(exit with X) :\n" ;
while (1)
{
    $line = <STDIN> ;
    last if ($line eq "X\n") ;
    print (FILE $line) ;
}

close FILE ;
open (FILE, '<', $file) ;
print "\n\"$file\" content is :\n" ;
while (<FILE>)
{
    print $_;
};
