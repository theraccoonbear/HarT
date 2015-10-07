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
use HarT::Util;

my $cfg_file = dirname(abs_path($0)) . '/config.json';

if (! -f $cfg_file) {
    (my $cfg_tmpl = $cfg_file) =~ s/\.json/\.example.json/;
    print "You don't have a config.json file!  I've copied config.sample.json as a starting template.\nPlease edit to include the appropriate values.\n\n";
    `cp '$cfg_tmpl' '$cfg_file'`;
    exit(0);
}

my $cfg = decode_json(read_file($cfg_file));

my $hart = new HarT::Util(config => $cfg);


my $command = lc($ARGV[0] || 'report');

if ($command eq 'report') {
    $hart->report();    
} else {
    print "I don't know how to \"$command\".\n";
    exit(0);
}