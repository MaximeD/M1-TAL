#!/usr/bin/env perl
use strict;
use warnings;
use utf8;
binmode(STDIN,  'utf8');
binmode(STDOUT, 'utf8');
binmode(STDERR, 'utf8');

=pod

=head1 NAME

B<Go Plural!>

Gives you the plural form of an adjective.

=head1 Synopsis

&plural_form($adjective)


=cut


my $adjective = "petite";

my $adjective_plural = &plural_form($adjective) ;

print "Le pluriel de l'adjectif '$adjective' est '$adjective_plural'\n";


sub plural_form {
  my ($base_adjective) = @_ ;
  my $plural_form ; # the plural form of the adjective we want to get

  # check the endings,
  # if it is 's' or 'x', there will be no change
  if (substr($base_adjective, -1) eq ('s' || 'x')) {
    $plural_form = $base_adjective;
  }

  # if it is 'eu' or 'au', the plural gets a 'x'
  # ex. 'hebreu' -> 'hebreux'
  elsif (substr($base_adjective, -2) eq ('eu' || 'au')) {
    $plural_form = $base_adjective . 'x' ;
  }

  # if it is 'al', the plural is 'aux'
  # ex. 'royal' -> 'royaux'
  elsif (substr($base_adjective, -2) eq 'al') {
    $plural_form = substr($base_adjective, 0, -2) . 'aux' ;
  }

  # if it is 'eau', the plural is 'eaux'
  # ex. 'beau' -> 'beaux'
  elsif (substr($base_adjective, -3) eq 'eau') {
    $plural_form = substr($base_adjective, 0, -3) . 'eaux' ;
  }
  else {
    $plural_form = $base_adjective . 's' ;
  }

  return $plural_form ;
}
