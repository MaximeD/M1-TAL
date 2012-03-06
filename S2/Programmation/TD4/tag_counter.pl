#!/usr/bin/env perl
use strict;
use warnings;
use utf8;
binmode(STDIN,  'utf8');
binmode(STDOUT, 'utf8');
binmode(STDERR, 'utf8');

=pod

=head1 NAME

B<Tag counter>

Counts the number of tags from a CONLL file

=head1 Synopsis

&count($corpus, $tag)

=cut

my $file = "outGP_CONLL.out";
my $tag  = "suj";

my $number_of_tags = &count($file,$tag);

print "On trouve $number_of_tags fois l'étiquette '$tag' dans le corpus '$file'\n";

sub count {
  my ($file, $tag) = @_;
  my $count;

  open(CORPUS, '<', $file);
  while (<CORPUS>) {
    if ($_ =~ m/\t$tag\t/) {
      $count++;
    }
  }
  close(CORPUS);

  return $count;
}

