#!/usr/bin/env perl
use strict;
use warnings;

open(F, '<:utf8', "en.txt");

my @gramm = my ( %gramm1, %gramm2, %gramm3, %gramm4) ;

while (<F>) {
  for my $word(split(/\pP|\pS|\s/, $_)){
    $gramm1{$+{last1}}++ if $word =~ (/(?<last1>.$)/) ;
    $gramm2{$+{last2}}++ if $word =~ (/(?<last2>..$)/) ;
    $gramm3{$+{last3}}++ if $word =~ (/(?<last3>...$)/) ;
    $gramm4{$+{last4}}++ if $word =~ (/(?<last4>....$)/) ;
  }
}

my @sorted1 = sort { ( $gramm1{$b} <=> $gramm1{$a}) or ($a cmp $b) } keys %gramm1 ;
my @sorted2 = sort { ( $gramm2{$b} <=> $gramm2{$a}) or ($a cmp $b) } keys %gramm2 ;
my @sorted3 = sort { ( $gramm3{$b} <=> $gramm3{$a}) or ($a cmp $b) } keys %gramm3 ;
my @sorted4 = sort { ( $gramm4{$b} <=> $gramm4{$a}) or ($a cmp $b) } keys %gramm4 ;

# displaying
print "Terminaisons : 1\n" ;
for (my $i = 0 ; $i < 10 ; $i++) {
  print "$sorted1[$i] \t". $gramm1{$sorted1[$i]} . "\n";
}

print "\nTerminaisons : 2\n" ;
for (my $i = 0 ; $i < 10 ; $i++) {
  print "$sorted2[$i] \t". $gramm2{$sorted2[$i]} . "\n";
}

print "\nTerminaisons : 3\n" ;
for (my $i = 0 ; $i < 10 ; $i++) {
  print "$sorted3[$i] \t". $gramm3{$sorted3[$i]} . "\n";
}

print "\nTerminaisons : 4\n" ;
for (my $i = 0 ; $i < 10 ; $i++) {
  print "$sorted4[$i] \t". $gramm4{$sorted4[$i]} . "\n";
}
