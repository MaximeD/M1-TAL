#!/usr/bin/env ruby

# Readlines
puts "Please enter the terms you want to add to your list
and quit with CTRL+D\n";

array = Array.new

while array !=''
  array=gets.chomp
end
puts array
#while l=gets.chomp and l != "end" do arr << l end
#while |= gets.chomp <<| arr end

  

# while ($ligne = <STDIN>) {
# # Enlever le caractère "fin de ligne"
#     chomp($ligne);
# # Placer la ligne dans le tableau
#     push (@lignes, $ligne) ;
# }

# # Afficher le tableau
# print "\@lignes : @lignes\n" ;

# # Afficher le nombre d'éléments du tableau
# print "That is " . ($#lignes + 1) . " elements\n";

# # Afficher le dernier élément du tableau
# print "And the last one of them is \"$lignes[-1]\"\n" ;
