#!/usr/bin/ruby

array, places =[1,2,3,8,5,8,0,4], []

puts "Maximum value of array is " + array.max.to_s

array.each_index do |x|
    places << x if array[x] == array.max
end

puts "You can find " + array.max.to_s + " in position " + places.join(", ")
