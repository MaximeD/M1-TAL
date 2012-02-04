#!/usr/bin/env perl
use strict;
use warnings;
use utf8;
binmode(STDIN, "utf8");
binmode(STDOUT, "utf8");
binmode(STDERR, "utf8");

# where the latin1 files are
my $dir = "corpuslatin1" ;
my @files = <$dir/*.txt> ;

foreach my $file(@files) {
    open(INPUT, '<:encoding(Latin1)', $file);
    my $file_out = $file . ".utf8" ;
    open(OUTPUT, '>:utf8', $file_out);

    while (<INPUT>) {
	print OUTPUT $_; # Automatically converts UTF-8 to Latin9
    }

    close(INPUT);
    close(OUTPUT);
}
