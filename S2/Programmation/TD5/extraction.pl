#!/usr/bin/env perl
use strict;
use warnings;
use utf8;
binmode(STDIN, 'utf8');
binmode(STDERR, 'utf8');
binmode(STDOUT, 'utf8');

=pod

=head1 NAME

B<TreeTagger: extraction>

Extracts verbs or adjectives from a TreeTagger output

=head1 Synopsis

=over

=item @present_forms = &search_verb($file,$verb_form)

List verbs in file

=item @present_adj = &search_adj($file)

List adjective in file

=back
=cut

my $file    = "treetagger.txt.tag" ;
my $lookfor = "faire" ;

# get the list of verbs where form is $look_for
my @present_forms = &search_verb($file,$lookfor);

# print output
if (scalar(@present_forms) > 0) {
  print "Les formes de \"$lookfor\" présentes dans le texte sont :\n";
  print join(", ", @present_forms) . "\n";
}


# get the list of adjectives
my @present_adj = &search_adj($file);

# print output
if (scalar(@present_adj) > 0) {
  print "Les adjectifs présents dans le texte sont :\n";
  print join(", ", @present_adj) . "\n";
}

sub search_verb {
  my ($file,$lookfor) = @_ ;
  my @present ;

  open(FILE, '<', $file) or die;
  while (<FILE>) {
    my @line = split(/\t/, $_) ;
    # remove windows CRLF
    $line[2] =~ s!\r\n!! ;
    if ($line[2] eq $lookfor) {
      push @present, $line[0];
    }
  }

  close(FILE);

  return @present;
}


sub search_adj {
  my ($file) = @_ ;
  my @present ;

  open(FILE, '<', $file) or die;
  while (<FILE>) {
    my @line = split(/\t/, $_) ;
    if ($line[1] eq 'ADJ') {
      push @present, $line[0];
    }
  }

  close(FILE);

  return @present;
}
