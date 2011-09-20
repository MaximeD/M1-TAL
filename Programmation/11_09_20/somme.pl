#!/usr/bin/perl -w

use strict ;

my @a = (12, 5, 18, 23, 55, 67, 42) ;
my $sum; my $a; my $total;

# foreach :
print "Code using the foreach function\n" ;

## sum
foreach (@a){
    $total += $_ ;
}
print "The sum is : $total\n" ;

## average
my $foreach_avg = $total / $#a ;
print "The average is : $foreach_avg\n" ;


# for :
print "\nCode using the for function\n" ;

## sum
my $for_total = 0;
($for_total += $_) for @a;

print "The sum is : $for_total\n" ;

## average
my $for_avg = $for_total / $#a ;
print "The average is : $for_avg\n" ;





