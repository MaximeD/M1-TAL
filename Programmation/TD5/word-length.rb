#!/usr/bin/env ruby

count = 0

File.open("conteGrimm.txt").each do |line|
  line.scan(/\b\w{5}\b/).each { |m| count += 1}   
end
  
puts "There are #{count} 5-letters length words"


count = 0
words = Array.new

puts "You found them on the following lines :"
File.open("conteGrimm.txt").each do |line|
  count +=1
  words.clear
  line.scan(/\b\w{5}\b/).each do |word|
    words << word
  end
  puts "l #{count} : #{words.join(", ")}" unless words.empty?
end
