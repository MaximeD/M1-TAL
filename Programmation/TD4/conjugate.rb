#!/usr/bin/ruby
# encoding: utf-8


class Grammar
  Pronoms = [ "je", "tu", "il/elle", "nous", "vous", "ils/elles" ] ;
  Terminaisons_1 = [ "e", "es", "e", "ons", "ez", "ent" ] ;
  Terminaisons_2 = [ "is", "is", "it", "issons", "issez", "issent" ] ;

  def conjugate( verb )
    unless verb =~ /(e|i)r$/
      puts "Ceci n'est pas un verbe du premier ou du second groupe !"
      exit 1
    end

    terminaisons = $1 == 'e' ? Terminaisons_1 : Terminaisons_2
    
    puts "\nLes formes du verbe #{verb} au présent de l'indicatif sont :\n"
    
    inf = verb.gsub(/.{2}$/, "")
    Pronoms.each_index do |x|
      puts Pronoms[x] + " " + inf + terminaisons[x] + "\n"
    end
  end
end


puts "Entrez un verbe du 1er ou 2nd groupe :\n"
Grammar.new.conjugate gets.chomp
