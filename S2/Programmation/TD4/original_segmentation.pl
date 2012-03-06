#!/usr/bin/env perl
use strict;
use warnings;
use utf8;
binmode(STDIN,  'utf8');
binmode(STDOUT, 'utf8');
binmode(STDERR, 'utf8');

=pod

=head1 NAME

B<Original segmentation>

Get back to the original segmentation of a sentence edited by a MT

=head1 Synopsis

&original_seg($file)

=cut

my $file = "mten.tag";

my $original = &original_seg($file);


sub original_seg {
  my ($file) = @_;
  my $text;

  open(CORPUS, '<', $file);
  while (<CORPUS>) {
    $_ =~ s/: \n/:/;
    $_ =~ s/; \n/;/;
#    $_ =~ s/\. \n/\./;
    print $_;
  }
  close(CORPUS);

  return $text;
}

