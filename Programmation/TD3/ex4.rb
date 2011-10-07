#!/usr/bin/ruby

array=[1,2,0,3,3,5,0,4]
value_to_search = 3
total = 0

array.each{|x|
  if x == value_to_search
    total += 1
  end
}

puts "There is " + total.to_s + " time(s) \"" + value_to_search.to_s + "\" in array"
