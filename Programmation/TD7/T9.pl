#!/usr/bin/env perl

use strict ;
use warnings ;
use utf8 ;
use Encode qw(encode decode);

# Simulates cellphone's T9

my %t9 = (
	       2 => "abcàâç",
	       3 => "deféèê",
	       4 => "ghi",
	       5 => "jkl" ,
	       6 => "mnoô" ,
	       7 => "pqrs" ,
	       8 => "tuvù" ,
	       9 => "wxyz"
	      ) ;

open(LEXIQUE, '<:utf8', "lexique.txt") or die ;

print encode("utf8","Veuillez entrer une séquence de touches\n") ;
chomp(my $touches = <STDIN>) ;
die encode("utf8","Veuillez n'entrer que des chiffres") if $touches =~ /\D/ ;
die encode("utf8","Le chiffre 1 n'est associé à aucune lettre !") if $touches =~ /1+/ ;

# T9 convertion :

my $re ;
foreach my $i(split(//, $touches)) { # split: isolate digits and get array
  $re .= "[" . $t9{$i} . "]" ;
}

chomp(my @possibles = grep(/^$re$/, <LEXIQUE>)) ;

if (!@possibles) {
  print encode("utf8","Aucun mot ne correspond\n") ;
}
else {
    if (@possibles == 1) {
	print encode("utf8","La seule possibilité trouvée est :\n");
    }
    else {
	print encode("utf8","Les possibilités sont les suivantes :\n");
    }
  print encode("utf8","\"" . join("\", \"", @possibles) . "\"\n") ;
}

close(LEXIQUE) ;
