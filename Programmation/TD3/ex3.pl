#!/usr/bin/perl

use strict ;
use locale ;

my @tableau=(1,2,3,5,0,4) ;
my $value = 0 ;
my $tableau ;

# First solution
################################################

# if (grep $_ == $value, @tableau){
#     print "$value est contenu dans \@tableau\n"
# }
# else {
#     print "$value est contenu dans \@tableau\n" ;
# }


# Other solution
################################################

if ($value == $tableau)
{
    foreach $tableau(@tableau) { }
    print "$value est contenu dans \@tableau\n" ;
}
else {print "$value n'est pas dans le tableau\n" ;}
