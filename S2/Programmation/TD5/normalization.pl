#!/usr/bin/env perl
use strict;
use warnings;
use utf8;
use Unicode::Normalize; 
use Encode;
binmode(STDIN,  'utf8');
binmode(STDOUT, 'utf8');
binmode(STDERR, 'utf8');

 
=pod

=head1 NAME

B<Normalization>

Remove diacritics

=head1 Synopsis

&normalization($file)

=cut

local $/ = undef;

my $file   = "mtfr.tag" ;
my $output = "mtfr.tag.out" ;

&normalization($file);

sub normalization {
   my ($input) = @_ ;

   open(INPUT, '<', $input) or die;
   open(OUTPUT, '>', $output) or die;

   my $string = <INPUT>;

   $string = NFD($string);
   $string =~ s/\pM//og;
   print OUTPUT "$string\n";
}

