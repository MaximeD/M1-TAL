#!/usr/bin/env ruby

puts "Entrez un nom commun masculin singulier : "
$nom = gets.chomp


$pluriel = $nom + "s" # well, let's say that most of the time it works

puts "Les flexions de #{$nom} sont :
un #{$nom},
des #{$pluriel}\n" 
