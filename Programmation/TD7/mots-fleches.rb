#!/usr/bin/env ruby

# So chomp is not a valid method for array ?
class Array
  def chomp!
    each do |item|
      item.chomp! if item.class == String
    end
  end
end

puts "Type the word you want to complete :"
word = gets.chomp

if word =~ /\./

  possible = open('lexique.txt').grep(/\b#{word}\b/).chomp!
  
  if possible.any? # check array not empty ie. we have results
    puts "The following words would match :"
    puts "\"" + possible.join("\", \"") + "\""
  else
    puts "Sorry, no match found"
  end
else
  puts "\nYour word is already complete !!"
  puts "Please enter a dot \".\" for the unknown chars"
end

