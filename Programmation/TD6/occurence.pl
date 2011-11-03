#!/usr/bin/env perl

use Encode qw(encode decode);
use strict ;
use warnings ;
use utf8 ;

open(GRIMM, '<:encoding(utf8)', 'conteGrimm.txt') or die ;

# making a hash
my @mots ;
my %freq ;
while (my $ligne = <GRIMM>) {
  chomp ($ligne) ;
  @mots = split(/\pP|\pS|\s/, $ligne) ;
  foreach my $mot(@mots) {
    if ($mot ne ""){
      $freq{ lc ($mot) }++ ;
    }
  }
}


# Sorting the hash
my @sorted = sort { ( $freq{$b} <=> $freq{$a}) or ($a cmp $b) } keys %freq ;

# 10 most frequent words
print encode("utf8", "Les dix mots les plus fréquents et leur nombre d'occurences sont :\n");

my $i ;
for ($i = 0 ; $i < 10 ; $i++) {
  print encode("utf8", "$sorted[$i] \t $freq{$sorted[$i]} \n");
}


# hapax
print encode("utf8", "\nOn ne trouve qu'une seule occurence des mots suivants :\n") ;

my @once ;
foreach my $key(@sorted) {
  if ($freq{$key} == 1)
    {
      @once = (@once, $key) ;
    }
}
print encode("utf8", join (", ", @once)), "\n" ;


# 10 mots les plus longs
print "\nPour finir, les 10 mots les plus longs du fichier sont :\n" ;

my @sortedlength = sort {length $b <=> length $a || $a cmp $b} @mots;
my @long ;
for ($i = 0 ; $i < 10 ; $i++)
  {
    @long =(@long, $sortedlength[$i])
  }
print encode("utf8",join(", ", @long)), "\n" ;

close(GRIMM) ;
