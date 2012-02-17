#!/usr/bin/env perl
use strict;
use warnings;
use utf8;
binmode(STDIN,  'utf8');
binmode(STDOUT, 'utf8');
binmode(STDERR, 'utf8');

=head1 NAME

B<stemmer>

A simple stemmer to remove the ending of verbs
of the 1st group in french

=head1 SYNOPSIS

$base = &verb_stem($verb)

=cut

# list of endings for the first group
my @ending_first_group = ('e', 'es', 'ons', 'ez', 'ent',         # indicatif présent
			  'ai', 'as', 'a', 'ons', 'ez', 'ont',   # indicatif futur
			  'ais', 'ait', 'ions', 'iez', 'aient',  # indicatif imparfait
			  'âmes', 'âtes', 'èrent',               # passé simple
			  'ant'                                  # participe présent,gérondif
			 ) ;

my $verb = "aiment";

my $radical = &verb_stemmer($verb,@ending_first_group);

# check output
print $radical . "\n";

sub verb_stemmer {
  my ($verb,@endings) = @_;

  # first, sort the list of endings by length
  # so that we ensure an ending like "aient"
  # is not cut by a smaller like "ent"
  @endings = sort { length($b) <=> length($a) } @endings;

  # now compare endings with verb
  foreach my $ending(@endings) {
    # try to remove it
    if ($verb =~ s/$ending$//) {
      # return as soon as we get a match
      return $verb;
    }
  }
}
