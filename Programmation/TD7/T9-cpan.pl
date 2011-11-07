#!/usr/bin/env perl

# from
# http://cpansearch.perl.org/src/CADE/Text-T9-1.0/T9.pm
use strict ;
use warnings ;
use utf8 ;
use Encode qw(encode decode);

# Simulates cellphone's T9

our @T9NL = ( '', '', 'abc', 'def', 'ghi', 'jkl', 'mnoô', 'pqrs', 'tuv', 'wxyz' );
open(LEXIQUE, '<:utf8', "lexique.txt") or die ;
my @words = <LEXIQUE> ;

print encode("utf8","Veuillez entrer une séquence de touches\n") ;
chomp(my $num = <STDIN>) ;

if ($num =~ /^[2-9]+$/)
{
    my $re;
    for( 0 .. length( $num ) - 1 )
    {
	$re .= "[" . $T9NL[substr( $num, $_, 1 )] . "]";
    }
    $re = "^$re\$";
    chomp(my @solutions = grep { /$re/i } @words);
    
    print encode("utf8","\nLes possibilités sont les suivantes :\n");
    print encode("utf8","\"" . join("\", \"", @solutions) . "\"\n") ;
}

close(LEXIQUE);
