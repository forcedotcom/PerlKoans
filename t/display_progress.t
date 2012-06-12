#!/usr/bin/perl

use strict;
use warnings;

use lib '../lib';
use Perl::Koans qw(display_progress);

$Perl::Koans::TEST_COUNT = 100; # makes testing easier

Test::More::is (display_progress(0),   '_' x 50, '0%');
Test::More::is (display_progress(10),  'X' x  5 . '_' x 45, '10%');
Test::More::is (display_progress(20),  'X' x 10 . '_' x 40, '20%');
Test::More::is (display_progress(30),  'X' x 15 . '_' x 35, '30%');
Test::More::is (display_progress(40),  'X' x 20 . '_' x 30, '40%');
Test::More::is (display_progress(50),  'X' x 25 . '_' x 25, '50%');
Test::More::is (display_progress(60),  'X' x 30 . '_' x 20, '60%');
Test::More::is (display_progress(70),  'X' x 35 . '_' x 15, '70%');
Test::More::is (display_progress(80),  'X' x 40 . '_' x 10, '80%');
Test::More::is (display_progress(90),  'X' x 45 . '_' x  5, '90%');
Test::More::is (display_progress(100), 'X' x 50, '100%');

exit;

