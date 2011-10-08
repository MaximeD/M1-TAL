#!/usr/bin/ruby

array=[1,2,0,3,3,5,0,4]
value_to_search = 3
total = 0

array.each { |value| total += 1 if value == value_to_search}

# or :
# array.each do |value|
#       total += 1 if value == value_to_search
# end

puts "\"#{value_to_search}\" is #{total} time(s) in array"
