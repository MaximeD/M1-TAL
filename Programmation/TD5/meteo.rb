#!/usr/bin/env ruby

meteo = Hash.new

File.open("temperatures.csv").each do |line|
  if (/(\w+) (\d+) (\d+.\d+)/.match(line)) 
    meteo[$1] = $3.to_f
  end
end

puts "La ville la plus chaude est #{meteo.index(meteo.values.max)} avec #{meteo.values.max}°C de moyenne
À l'inverse, la ville la plus froide est #{meteo.index(meteo.values.min)} avec #{meteo.values.min}°C de moyenne"
