#!/usr/bin/ruby

array=[1,2,3,8,5,8,0,4]
places = Array.new

puts "Maximum value of array is " + array.max.to_s

array.each_index{|x|
  if (array[x] == array.max)
    places << x
  end
}

puts "You can find " + array.max.to_s + " in position " + places.join(", ")
