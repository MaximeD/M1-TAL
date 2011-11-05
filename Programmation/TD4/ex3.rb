#!/usr/bin/env ruby

text = File.new("noms-invariables.txt").read

puts "Type mascular french words,
comma separated :"

# getting string, splitting and converting to hash
flexions = Hash[gets.chomp.split(/, |,/).map {|val| [val, val]}]

flexions.each_key do |word|
  unless text =~ /\b#{word}\b/
      flexions[word] = word + "s"
  end
end

flexions.each do |word, plural|
  puts "\n"
  puts "Flexions of #{word} are :"
  puts "Un #{word}, des #{plural}"
end
