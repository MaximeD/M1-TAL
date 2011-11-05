#!/usr/bin/env perl

use strict ;
use warnings ;
use utf8 ;
use Encode qw(encode decode);

# Simulates cellphone's T9

my %t9 = (
	       1 => "",
	       2 => "[abcàâç]",
	       3 => "[deféèê]",
	       4 => "[ghi]",
	       5 => "[jkl]" ,
	       6 => "[mnoô]" ,
	       7 => "[pqrs]" ,
	       8 => "[tuvù]" ,
	       9 => "[wxyz]"
	      ) ;

open(LEXIQUE, '<:utf8', "lexique.txt") or die ;

print encode("utf8","Veuillez entrer une séquence de touches\n") ;
chomp(my $touches = <STDIN>) ;
die encode("utf8","Veuillez n'entrer que des chiffres") if $touches =~ /\D/ ;

my @touche = split(//, $touches) ; # isolate digits

# T9 convertion :
my $sequence ;
foreach my $i(@touche) {
  $sequence .= $t9{$i} ;
}

chomp(my @possibles = grep(/\b$sequence\b/, <LEXIQUE>)) ;

if (!@possibles) {
  print encode("utf8","Aucun mot ne correspond\n") ;
}
elsif (@possibles == 1) {
  print encode("utf8","La seule possibilité trouvée est :\n");
  print encode("utf8","\"$possibles[0]\"\n") ;
}
else {
  print encode("utf8","Les possibilités sont les suivantes :\n");
  print encode("utf8","\"" . join("\", \"", @possibles) . "\"\n") ;
}

close(LEXIQUE) ;

