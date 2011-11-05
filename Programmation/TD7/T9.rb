#!/usr/bin/env ruby

class Array
  def chomp!
    each do |item|
      item.chomp! if item.class == String
    end
  end
end

# Simulates cellphone's T9

t9 = Hash[
          1 => "",
          2 => "[abcàâç]",
          3 => "[deféèê]",
          4 => "[ghi]",
          5 => "[jkl]" ,
          6 => "[mnoô]" ,
          7 => "[pqrs]" ,
          8 => "[tuvù]" ,
          9 => "[wxyz]"
         ] ;

puts "Type in the numbers supposed to form a word"
numbers = gets.chomp.split(//)
abort("Please type digits only") if numbers =~ /\D/

s = String.new
numbers.each do |number|
  s << t9[number.to_i]
end

possible = open('lexique.txt').grep(/\b#{s}\b/).chomp!

if possible.any?
  puts "Found the following words :"
  puts "\"" + possible.join('", "') + "\""
else
  puts "Sorry, nothing found"
end
