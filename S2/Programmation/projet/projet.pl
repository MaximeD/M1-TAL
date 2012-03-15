#!/usr/bin/env perl
use strict;
use warnings;
use utf8;
binmode(STDIN, 'utf8');
binmode(STDOUT, 'utf8');
binmode(STDERR, 'utf8');

use Data::Dumper;
#############
# main vars #
#############

# the place where the docs are stored
my $path_doc  = "documents/";

# where the results are stored
my $output = "results.csv";


my @docs = &read_docs($path_doc);

# this sub modifies @doc
# and create a hash of word/frequency
&word_frequency(\@docs);

&tfidf(\@docs);

my @matrix = &matrix(\@docs);

# if you want to print the matrix content
# print Dumper(@matrix);

&matrix2csv(\@matrix,$output);




########
# subs #
########

sub read_docs {
  # this sub reads docs in path
  # and push them in an array

  my ($path_doc) =  @_;

  # get the list of docs to analyse
  opendir(DIR, $path_doc);

  # the array with the files
  my @docs;

  foreach my $file (readdir(DIR)) {
    # check it is a text file
    next unless (-f $path_doc . $file);

    # populate the array with informations
    # concerning files
    push @docs, {
		 name 	=> $file,
		 source	=> $path_doc . $file,
		 data   => '',
		}
  }
  closedir(DIR);
  return @docs;
}


sub word_frequency {
  my ($docs) = @_;
  my @docs = @$docs;

  # process every doc
  for (my $i = 0; $i < @docs; $i++){
    print STDERR "Processing $docs[$i]{ name }...\n";

    # declare the hash {word => frequency}
    my %freq;

    # open doc
    open(DOC, '<', $docs[$i]{ source })
      or die;

    # process doc and populate hash with word frequencies
    while(<DOC>) {
      my @words = split(/\pP|\pS|\s/, $_) ;
      foreach my $word(@words) {
	if ($word ne "") {
	  $freq{ lc($word) }++ ;
	}
      }
    }
    close(DOC);

    # add the hash as the value of the new key data
    # (once per doc) reference is needed
    $docs[$i]{ data } = \%freq;
  }
}

sub tfidf {
  my ($docs) = @_ ;
  my @docs = @$docs;

  my %words_idf = &idf($docs) ;

  # and last compute if * idf
  for (my $i = 0; $i < @docs; $i++) {
    my $word_freq = $docs[$i]{ data };
    foreach my $term ( keys %$word_freq ) {
      $docs[$i]{ data }{ $term } *=  $words_idf{ $term };
      # print "$word\n";
    }
  }
}

sub idf {
  my ($docs) = @_ ;
  my @docs = @$docs;

  # Create a hash of words and their idf
  my %words_idf;

  # first compute in how many docs the term is found
  foreach my $document(@docs) {
    # declaring dereference is needed
    # to use each/keys/values
    my %document = %$document;

    while (my ($k,$v) = each %document) {
      if ($k eq 'data') {
	my %data = %$v;
	while (my ($term, $freq) = each %data) {
	  # print $term . $freq ."\n";
	  $words_idf{ $term }++;
	}
      }
    }
  }

  # compute the cardinality (ie. the number of docs)
  my $D_cardinality = scalar(@docs);

  # second compute the idf
  while (my ($word, $value) = each %words_idf) {
    $words_idf{ $word } = log($D_cardinality / $value);
  }
  return %words_idf;
}

################################################
# Now we have every results we need to compare #
################################################

sub matrix {
  my ($docs) = @_;
  my @docs = @$docs ;

  # create an array of array
  # storing each doc similarity with each other
  my @matrix;

  # fill out the first colum
  # notice in this one, first row is empty
  push @matrix, (
		 [""]
		);

  foreach (@docs) {
    my %tmp_hash = %$_ ;
    push @{ $matrix[0] }, $tmp_hash{ name };
  }


  for (my $i = 0; $i < @docs; $i++) {
    # declare new column we want to fill
    my @matrix_column;

    for (my $j = @docs - 1 ; $j >= $i;$j--) {
      my $base_word = $docs[$i]{ data };
      my $comp_word = $docs[$j]{ data };

      # vars needed for computing cosine similarity
      my ($numerator, $norm_doc1, $norm_doc2,$denominator,$cos);

      foreach my $term ( keys %$base_word ) {
	$numerator += $docs[$i]{ data }{ $term } * $docs[$j]{ data }{ $term } if exists $docs[$j]{ data }{ $term };
	$norm_doc1 += $docs[$i]{ data }{ $term } ** 2;
	$norm_doc2 += $docs[$j]{ data }{ $term } ** 2 if exists $docs[$j]{ data }{ $term };
      }
      $denominator = sqrt($norm_doc1) * sqrt($norm_doc2);
      $cos = $numerator / $denominator ;

      # since we proceed from the end
      # notice the $j--
      # we need to add values at the beginning of array,
      # not the end (the other way round)
      unshift @matrix_column, $cos;
    }

    # still because we start from the end,
    # we need to fill empty rows
    unshift @matrix_column, "" foreach(1..$i);

    # now we add the name of the column at the beginning
    unshift @matrix_column, $docs[$i]{ name };

    # and we can push it to our array!
    push @matrix, [@matrix_column];
  }
  return @matrix;
}


sub matrix2csv {
  my ($matrix,$output) = @_;
  my @matrix = @$matrix;

  # now we can print our array to a csv file
  open(CSV, '>', $output);
  foreach my $column (@matrix) {
    my @column = @$column;

    print CSV join("\t", @column) . "\n";
  }
  close(CSV);
}

