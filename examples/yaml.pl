#!perl

# This script
# from 2144kb using YAML
#   to 1632kb using tiny (and YAML::Tiny)
#
# $Id: $

use strict;
use warnings;
use Data::Dumper;
use tiny;
use YAML;

my $y = YAML->new();
print $y, "\n";

my $x = $y->LoadFile('examples/test.yaml');

print Dump($y), "\n";

sleep 20;

print Dumper($y);

