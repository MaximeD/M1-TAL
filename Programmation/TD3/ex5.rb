#!/usr/bin/ruby

array, places =[1,2,3,8,5,8,0,4], []

puts "Maximum value of array is " + array.max.to_s

array.each_with_index do |value,index|
    places << index if value == array.max
end

puts "You can find " + array.max.to_s + " in position " + places.join(", ")
