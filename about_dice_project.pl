#!/usr/bin/perl
=pod
    Copyright (c) 2012, Salesforce.com, Inc.
    All rights reserved.
    
    Redistribution and use in source and binary forms, with or without modification,
    are permitted provided that the following conditions are met:
    
    Redistributions of source code must retain the above copyright notice, this list
    of conditions and the following disclaimer. Redistributions in binary form must
    reproduce the above copyright notice, this list of conditions and the following
    disclaimer in the documentation and/or other materials provided with the
    distribution.
    
    Neither the name of salesforce.com, inc. nor the names of its contributors may be
    used to endorse or promote products derived from this software without specific
    prior written permission.
    
    THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
    ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
    WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
    DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
    FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
    DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
    SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
    CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
    OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT
    OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
=cut

package Perl::Koans::Dice; # yes, this is a pretty direct rip.. going to use 12 sided dies instead, but still would prefer something more original
use warnings;

use lib './lib';
use Perl::Koans;

################
# your code goes below this line

sub roll {
    
}

sub count {
    
}

# your code goes above this line
################

unless (caller(0)) {
    run(@ARGV) or print_illumination();
    exit();
}

sub run {
    # run() -- runs all functions in this module
    my $results = 0;
    
    my @roll_one_die = roll(1);
    is (scalar @roll_one_die, 1, 'roll(n) rolls n dies');
    ok ($roll_one_die[0] > 0 && $roll_one_die[0] <= 12, 'roll(n) returns an array with all elements between 1 and 12');
    
    my @roll_three_dice = roll(3, 1);
    is (scalar @roll_three_dice, 3, 'roll(n) rolls n dies -- part 2');
    ok ($roll_one_die[0] != $roll_three_dice[0], 'calling roll(n) twice should never return the same values');
    
    my $count = count(\@roll_three_dice);
    # fix this 
    is ($count, (map { $x += $roll_three_dice[$_] } @roll_three_dice), 'count(\@array) sums the values of the rolls in @array');
    
    
    return ($results) ? bail($results) : $results;
}


1;
