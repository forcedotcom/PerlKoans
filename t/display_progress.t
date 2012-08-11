#!/usr/bin/perl

use strict;
use warnings;

use lib '../lib';

use Perl::Koans qw(display_progress);

$Perl::Koans::TEST_COUNT = 100; # makes testing easier

my $complete   = 'X';
my $incomplete = '_';

Test::More::is (display_progress(0),   $incomplete x 50, '0%');
Test::More::is (display_progress(10),  $complete x  5 . $incomplete x 45, '10%');
Test::More::is (display_progress(20),  $complete x 10 . $incomplete x 40, '20%');
Test::More::is (display_progress(30),  $complete x 15 . $incomplete x 35, '30%');
Test::More::is (display_progress(40),  $complete x 20 . $incomplete x 30, '40%');
Test::More::is (display_progress(50),  $complete x 25 . $incomplete x 25, '50%');
Test::More::is (display_progress(60),  $complete x 30 . $incomplete x 20, '60%');
Test::More::is (display_progress(70),  $complete x 35 . $incomplete x 15, '70%');
Test::More::is (display_progress(80),  $complete x 40 . $incomplete x 10, '80%');
Test::More::is (display_progress(90),  $complete x 45 . $incomplete x  5, '90%');
Test::More::is (display_progress(100), $complete x 50, '100%');

exit;

