#!/usr/bin/env ruby

puts "What is your name ?\n"
$name = gets.chomp

puts "Hello " + $name + ", how old are you ?\n"
$age = gets.chomp

puts "So you are " + $age + " years old\n"
puts "Have " << "a " << "nice " << "day " << $name << "\n"
