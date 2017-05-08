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

use WebService::Harvest;
use Time::DayOfWeek qw(:dow);
use DateTime::Format::Strptime;

my $cfg_file = dirname(abs_path($0)) . '/config.json';

if (! -f $cfg_file) {
    (my $cfg_tmpl = $cfg_file) =~ s/\.json/\.example.json/;
    print "You don't have a config.json file!  I've copied config.sample.json as a starting template.\n\n";
    `cp '$cfg_tmpl' '$cfg_file'`;
    exit(0);
}

my $cfg = decode_json(read_file($cfg_file));

my $daily_std = $cfg->{daily_standard_hours} || 7.84615384615;
my $daily_target = $cfg->{daily_target_hours} || 8.5;

my $harvest = new WebService::Harvest(config => $cfg);

my $entries = $harvest->getEntries('20170501', '20171231');
#my $projects = $harvest->listProjects();
#my $project = $harvest->getProject(13593722, '20170101', '20170508');

#p($entries);
#p($projects);
#p($project);

#p($harvest->whoAmI());
