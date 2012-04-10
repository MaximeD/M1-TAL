#!/usr/bin/env ruby

File.open("outGP_CONLL.out").each do |line|
  column = line.split("\t")
  puts "#{column[1]}"
  puts "\t#{column[3]}"
  puts "\t #{column[5]}"
end

