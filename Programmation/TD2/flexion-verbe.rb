#!/usr/bin/env ruby

myPronoms = ["je", "tu", "il/elle", "nous", "vous", "ils/elles"]
myTerminaisons = ["e", "es", "e", "ons", "ez", "ent"]

puts "Entrez un verbe du 1er groupe : "
verbe = gets.chomp
radical = verbe.gsub(/er$/, '')

puts "Les formes du verbe " + verbe + " au présent de l'indicatif sont :\n"


(0..myPronoms.length).each{|i| puts myPronoms[i] + " " + radical + myTerminaisons[i]}

