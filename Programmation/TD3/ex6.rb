#!/usr/bin/env ruby

phrase = "This is a phrase made of few words"
phrase.downcase!

# How many words in phrase ?
myPhrase = phrase.split
puts "phrase is " + myPhrase.length.to_s + " words length"

# who are the first and last words ?
myPhrase.sort!

puts "Alphabetically,
phrase first word is \"" + myPhrase[0] +
"\" and last word is \"" + myPhrase[-1] + "\""



