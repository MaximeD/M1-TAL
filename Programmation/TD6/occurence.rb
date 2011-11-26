#!/usr/bin/env ruby

text = String.new
File.open('conteGrimm.txt', 'r') { |line| text = line.read}
words = text.split(/[ \n\.\?'\:,‒;]/)

occurence = Hash.new(0)
words.each { |word| occurence[word] += 1 unless word == ""}

puts "The 10 most frequent words are :\n"
occurence.sort_by { |k,v| v}.reverse.first(10).each {|word, freq| puts word + ' : ' + freq.to_s}


puts "\nThere is just one occurence of the following terms :\n"
once = Array.new
occurence.each { |word, freq| once << word if freq == 1}
puts once.join(", ")


puts "\nAnd last (but not least!), the 10 longest words are :\n"
long = occurence.keys.sort_by {|w| w.length }.reverse.first(10)
puts long.join(", ")
