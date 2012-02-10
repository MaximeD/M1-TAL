#!/usr/bin/env ruby

files = Array.new

Dir.glob("corpustest/*.txt") do |file|
  files << file
end

class Stats

  def initialize(file)
    puts file
    input = File.open(file, "r")
    @word_list = Array.new
    input.each do |line|
      words = line.split(" ")
      words.each do |word|
        @word_list << word
      end
    end
    input.close
  end
  
  def token
    $token = @word_list.length
    puts "token: #{$token}"
  end

  def words
    freqs = Hash.new { |h,k| freqs[k] = 0 }
    @word_list.each { |e| freqs[e] += 1 }
    $word_total = freqs.length

    puts "words: #{$word_total}"
  end

  def ratio
    ratio = $word_total.to_f / $token
    puts "ratio: #{ratio}"
  end

end
 

files.each do |file|
  fichier = Stats.new(file)
  fichier.token
  fichier.words
  fichier.ratio
  puts
end

