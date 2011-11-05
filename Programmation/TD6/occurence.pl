#!/usr/bin/env perl

use Encode qw(encode decode);
use strict ;
use warnings ;
use utf8 ;

my @sorted ;
my %freq ;

sub hash($){
  my $fileHandle = $_[0];
  while (<$fileHandle>)
    {
      chomp($_);
      my @mots = split(/\pP|\pS|\s/, $_) ;
      foreach my $mot(@mots) {
	if ($mot ne ""){
	  $freq{ lc ($mot) }++ ;
	}
      }
    }
  # sorting hash by freq :
  @sorted = sort { ( $freq{$b} <=> $freq{$a}) or ($a cmp $b) } keys %freq ;
}

sub mostFrequent{
  print encode("utf8", "Les dix mots les plus fréquents et leur nombre d'occurences sont :\n");
  my $i ;
  for ($i = 0 ; $i < 10 ; $i++) {
    print encode("utf8", "$sorted[$i] \t $freq{$sorted[$i]} \n");
  }
}

sub hapax{
  print encode("utf8", "\nOn ne trouve qu'une seule occurence des mots suivants :\n") ;
  my @hapax ;
  foreach my $key(@sorted) {
    if ($freq{$key} == 1)
      {
	@hapax = (@hapax, $key) ;
      }
  }
  print encode("utf8", join (", ", @hapax)), "\n" ;
}

sub longest{
  print "\nLes 10 mots les plus longs du fichier sont :\n" ;
  my @sortedlength = sort {length $b <=> length $a or ($a cmp $b)} keys(%freq);
  my @long ;
  my $i;
  for ($i = 0 ; $i < 10 ; $i++)
    {
      @long =(@long, $sortedlength[$i])
    }
  print encode("utf8",join(", ", @long)), "\n" ;
}


my $file;
open($file, '<:utf8', "conteGrimm.txt") or die "Could not open file\n";

&hash($file);
&mostFrequent;
&hapax;
&longest;

close($file);

