#!perl -T

use Test::More tests => 1;

BEGIN {
	use_ok( 'tiny' );
}

diag( "Testing tiny $tiny::VERSION, Perl $], $^X" );
