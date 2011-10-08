#!/usr/bin/ruby

puts  "Entrez un nom commun singulier :"
nom = gets.chomp

invar = ["ours", "lynx", "putois"]

pluriel = nom + "s"
pluriel = nom if invar.include?(nom)

puts "\nLes flexions de " + nom + " sont :\n"
puts "un " + nom + ", des " + pluriel
