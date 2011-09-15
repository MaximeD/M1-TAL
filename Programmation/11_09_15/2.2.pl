#!/usr/bin/perl -w

use strict ;

my $x = 'aa' ;
my $y = "bb BB" ;
my $z = `date` ; #Attention , ces guillemets sont obtenus par Alt Gr + 7
my $w = qx/pwd/ ;
my $u = "${x}QQ$y" ;
my $v = '${x}QQ$y' ;

# Affichage
print '$x= ' , $x , "\n" ;
print '$y= ' . $y . "\n" ;
print "\$z= $z\n" ;
print qq(\$w = $w\n ) ;
print q | $u = | , $u , "\n" ;
print <<ENDSTR
\$v = $v
ENDSTR
;

my $complex_str = <<END
Une très, très, très , longue chaîne de caractères
bla bla bla bla bla bla bla bla
bla bla bla bla bla bla bla bla
bla bla bla bla bla bla bla bla
END
;
chomp( $complex_str ) ;
print "$complex_str\n" ;
