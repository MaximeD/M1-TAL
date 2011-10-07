#!/usr/bin/ruby

puts  "Entrez un nom commun singulier"
nom = gets.chomp

pluriel = nom + "s"

invar = ["ours", "lynx", "putois"]

if invar.include?(nom)
  pluriel = nom
else
  pluriel = nom + "s"
end

puts "Les flexions de " + nom + " sont :\n"
puts "un " + nom + ", des " + pluriel
