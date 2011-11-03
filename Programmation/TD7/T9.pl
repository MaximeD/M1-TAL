#!/usr/bin/env perl

use strict ;
use warnings ;

# Simulates the T9 on cellphones

my %t9 = (
	       1 => "",
	       2 => "[abcàâç]",
	       3 => "[deféèê]",
	       4 => "[ghi]",
	       5 => "[jkl]" ,
	       6 => "[mno]" ,
	       7 => "[pqrs]" ,
	       8 => "[tuvù]" ,
	       9 => "[wxyz]"
	      ) ;

open(LEXIQUE, '<', "lexique.txt") or die ;

print "Veuillez entrer une séquence de touches\n" ;
chomp(my $touches = <STDIN>) ;
die "Veuillez n'entrer que des chiffres" if $touches =~ /\D/ ;

my @touche = split(//, $touches) ; # isolate digits

my @sequence ;
foreach my $i(@touche) {
  @sequence = (@sequence, $t9{$i}) ;
}

my $sequence =  join("", @sequence) ;

my @possibles = grep(/^$sequence$/, <LEXIQUE>) ;

print "Les possibilités sont les suivantes :\n";
print join(", ", @possibles) ;

close(LEXIQUE) ;

