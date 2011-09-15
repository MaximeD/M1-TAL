#!/usr/bin/perl -w

$age=21;
$prenom="Marie" ;

# Affichage avec des guillemets doubles
$s1 = "$prenom a $age ans\n" ;
print "\$s1 : $s1" ;

#Affichage avec des guillemets simples
$s2 = '$prenom a $age ans\n' ;
print "\$s2 : $s2" ;

#Concaténation
$s3 = $prenom . " a " . $age . " ans\n" ;
print "\n\$s3 : $s3" ;

# exercise
$exo = "exo : " . $prenom . " aura " . ($age + 1) . " ans la semaine prochaine\n" ;
print $exo ;

