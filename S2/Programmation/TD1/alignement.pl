#!/usr/bin/env perl
use strict;
use warnings;
use utf8;
binmode(STDOUT, 'utf8');

my @files = ("test.en", "test.fr");

foreach my $file(@files) {
  open(FILE, '<', $file);

  my $content ;
  while (<FILE>) {
    $_ =~ s/\./\n\.EOS\n/mg;
    foreach my $token(split(" |'", $_)) {
      $content .= $token . "\n";
    }
  }
  close(FILE);

  $content =~ s/(\n\r\n){2}/\n\.EOP\n/mg;
 print $content;
}

