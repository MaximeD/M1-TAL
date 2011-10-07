#!/usr/bin/ruby

$pronoms = [ "je", "tu", "il/elle", "nous", "vous", "ils/elles" ] ;
terminaisons_1 = [ "e", "es", "e", "ons", "ez", "ent" ] ;
terminaisons_2 = [ "is", "is", "it", "issons", "issez", "issent" ] ;


def conjugate(verb, terminaisons)
  puts "\nLes formes du verbe " + verb + " au présent de l'indicatif sont :\n"
  inf = verb.gsub(/.{2}$/, "")
  $pronoms.each_index{|x|
    print $pronoms[x] + " " + inf + terminaisons[x] + "\n"}
end

puts "Entrez un verbe du 1er ou 2nd groupe :\n"
verb = gets.chomp

if verb =~ /er$/
  conjugate(verb, terminaisons_1)
elsif
  verb =~ /ir$/
  conjugate(verb, terminaisons_2)
else
  puts "Ceci n'est pas un verbe du premier ou du second groupe !"
end
