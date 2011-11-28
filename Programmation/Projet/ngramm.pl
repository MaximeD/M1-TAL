#!/usr/bin/env perl
use strict;
use warnings;

open(F, '<:utf8', "en.txt");

sub suffix_weight {
    my $n = $_[0] ;      # How many gramms are we looking for ?
    
    my %gramm ;
    my $count ;
    
    while (<F>) {
	for my $word(split(/\pP|\pS|\s/, $_)){
	    $gramm{$+{last}}++ and $count++ if $word =~ (/(?<last>.{$n}$)/) ;
	}
    }
    
    # sorting hash by descending value
    my @sorted = sort { ( $gramm{$b} <=> $gramm{$a}) or ($a cmp $b) } keys %gramm ;
    
# displaying
    print "Terminaisons : $n\n" ;
    for (my $i = 0 ; $i < 10 ; $i++) {
	print "$sorted[$i] \t". $gramm{$sorted[$i]} / $count * 100 . "\n";
    }
    print "Total occurences : $count\n" ;
}

&suffix_weight(1) ; # arg is the number of gramms wanted

