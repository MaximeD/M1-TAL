#!/usr/bin/perl
use warnings ;
use strict ;

my ( $radical, $inf, $verb, $i ) ;
my @terminaisons ;
my @pronoms = ( "je", "tu", "il/elle", "nous", "vous", "ils/elles" ) ;
my @terminaisons_present_1 = ( "e", "es", "e", "ons", "ez", "ent" ) ;
my @terminaisons_present_2 = ( "is", "is", "it", "issons", "issez", "issent" ) ;
my @terminaisons_imparfait = ("ais", "ais", "ait", "ions", "iez", "aient") ; # idem pour tous les groupes :)


sub Conjugate{
  open(PRESENT, '>', "$verb-present.txt") ;
  ($inf = $verb) =~ s/.{2}$// ;

  for ($i=0; $i<@pronoms; $i++)
    {
      print (PRESENT $pronoms[$i] . " " . $inf . $terminaisons[$i] . "\n") ;
    }

  open(IMPARFAIT, '>', "$verb-imparfait.txt") ;
  # imparfait = 1ere pers pluriel + terminaisons
  ($inf = $inf . $terminaisons[3]) =~ s/.{3}$// ;
  for ($i=0; $i<@pronoms; $i++)
    {
      print (IMPARFAIT $pronoms[$i] . " " . $inf . $terminaisons_imparfait[$i] . "\n") ;
    }

}

print "Entrez un verbe du 1er ou du 2eme groupe : " ;
chomp($verb=<STDIN>) ;

if ($verb =~ m/er$/){
    @terminaisons = @terminaisons_present_1 ;
    &Conjugate ;
  }

elsif ($verb =~ m/ir$/){
  @terminaisons = @terminaisons_present_2 ;
  &Conjugate ;
}

else{die "\"$verb\" n'est pas un verbe du premier ou du second groupe !\n"}
