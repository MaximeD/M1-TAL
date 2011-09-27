#!/usr/bin/ruby -w

$age = 21
$prenom = "Marie"

# Affichage avec des guillemets doubles
puts "$s1 : #{$prenom} a #{$age} ans\n"

#Affichage avec des guillemets simples
puts '$s2 : #{$prenom} a #{$age} ans\n'

# Concaténation
puts "$s3 : " + $prenom + " a " + $age.to_s + " ans\n"

# exercise
puts "exo : " + $prenom + " aura " + ($age + 1 ).to_s  + " ans la semaine prochaine\n"


