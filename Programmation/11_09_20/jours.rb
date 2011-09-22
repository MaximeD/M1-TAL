#!/usr/bin/env ruby

myJours = ["lundi", "mardi", "mercredi", "jeudi", "vendredi", "samedi", "dimanche" ]
myDays = [ "monday", "tuesday", "wednesday", "thursday", "friday", "saturday", "sunday" ]
myTage = [ "Montag", "Dienstag", "Mittwoch", "Donnerstag", "Freitag", "Samstag", "Sonntag" ]

puts "Il y a " + myJours.length.to_s + " jours dans la semaine\n"
 
puts "Le dernier jour de la semaine est : " + myJours.last


puts "Le mot " + myJours[0] + " se traduit par " + myDays[0] + " en anglais et par " + myTage[0] + " en allemand\n\n"

for i in 0..(myJours.length - 1)
  puts "Le mot " + myJours[i].to_s + " se traduit par " + myDays[i].to_s + " en anglais et par " + myTage[i].to_s + " en allemand\n"
end
