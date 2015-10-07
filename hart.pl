#!/usr/bin/env perl
use strict;
use warnings;
use File::Slurp;
use JSON::XS;
use Data::Printer;
use Cwd qw(abs_path realpath);
use FindBin;
use File::Basename;
use lib dirname(abs_path($0)) . '/lib';
use Getopt::Long;

my $command = 'report';

#Getoptions