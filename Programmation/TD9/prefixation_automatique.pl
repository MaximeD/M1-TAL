#!/usr/bin/env perl
use strict;
use warnings;
use utf8;
use Encode qw(encode decode);

open(FILE, '<:utf8', "lefff-grace-utf8.txt");

print "Et voici les antonymes :\n";
while (<FILE>) {
  # Is an adj (Afpms) and ends with -able
  if ($_ =~ /Afpms$/ && $_ =~ m/^\w+?able\b/) {
    my $adj = $& ;
    if ($adj =~ m/^i[mrn]/) {      # already negative hey ?
      my $positive = $adj ;
      $positive =~ s/^i[mrn]// ;
      print encode("utf8", "$adj\t-->\t$positive\n");
    }
    elsif ($adj =~ m/^[bpm]/) {   # special case
      print encode("utf8", "$adj\t-->\tim$adj\n") ;
    }
    else {                        # else
      print encode("utf8", "$adj\t-->\tin$adj\n") ;
    }
  }
}
