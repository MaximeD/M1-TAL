#!/usr/bin/ruby

array=[1,2,3,5,0,4]

value_to_search = 8

if array.include?(value_to_search)
  puts "#{value_to_search} is in the array !\n"
else
  puts "#{value_to_search} is not in the array !\n"
end
