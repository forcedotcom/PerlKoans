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

package Perl::Koans::Loops;
use warnings;

use lib './lib';
use Perl::Koans;

################
# your code goes below this line

sub about_for {
    # about_for()
    
    # TODO write an explicit fencepost issue
    for (my $i = 0; $i < 10; $i++) {
        
        is ($i, __, 'a very common form of a for loop, incrementing a named variable from 0 to 9');
        
        last;
    }
    
    for (1..10) {
        
        is ($_, __, 'a common form of a for loop, incrementing the default variable from 1 to 10');
        
        last;
    }
    
    for (my $j = 10; $j > 0; $j--) {
        
        is ($j, __, 'a common form of a for loop, decrementing a named variable from 10 to 0');
        
        last;
    }
    
    for (reverse 1..10) {
        # for student: why doesn't 10..1 ?
        
        is ($_, __, 'an uncommon form of a for loop, decrementing the default variable from 10 to 1');
        
        last;
    }
    
    # now with predefined/complex variables
    my @array = ('a', 'b', 'c', 1, 2, 3, 'fizzbang');
    my %hash  = (
        foo => 1,
        bar => 2,
        baz => 3,
    );
    
	# foreach is a synonm for 'for' in list context
    for (@array) {
        
        is ($_, __, 'iterating the elements of an array');
        
        last;
    }
    
    for (my $i = 0; $i < $#array; $i++) {
        
        is (__, 'a', 'incrementing an iterator, using it to refer to array indicies'); # TODO rewrite this hint
        
        last;
    }
    

    # TODO need to talk about how perl doesn't do many in place changes (and the caveats to that--chomp/chop)
    for my $element (sort @array) {
        
        is ($element, __, 'sort() will return an array ordered in ASCIIbetical order');
        
        last;
    }
    
    for my $element (reverse @array) {
        
        is ($element, __, 'reverse() will return its operant in reverse order');
        
        last;
    }
    
    for my $element (reverse sort @array) {
        
        is ($element, __, 'reverse()ing a sort() will return its operant in reverse ASCIIbetical order');
        
        last;
    }

    for my $key (sort keys %hash) {
        # TODO: clarify comment below?
        # using sort here because the hashing order is unpredictable
        
        is ($key, __, 'hash keys are often sorted before they are iterated');
        
        
        last;
    }
    
    for my $value (sort values %hash) {
        
        is ($value, __, "this is less common, but sometimes you don't actually care about the keys themselves");
        
        last;
    }
    
    
    fail('last, next, redo, continue need coverage');
    
    
    return (Perl::Koans::get_return_code()); 
}

sub about_while {
    # about_while() - while loops execute as long as their sentinel test is 'true'
    
    my %hash = (
        fizz => 'bang',
    );
    
    while (my ($key, $value) = sort each %hash) {
        # each pulls ($key, $value) pairs from a hash
        
        is ($key,   __, 'each() returns a key/value pair from a hash -- part key');
        is ($value, __, 'each() returns a key/value pair from a hash -- part value');
        
        last;
    }
    
    while (1) {
        
        is (1, __, 'while(1) is used in place of "while(true)", runs until last() is called');
        
        last;
    }
    
    do {
        
        is (1, __, 'do while() loops execute at least once');
        
    } while (1 == 0);

    
    return (Perl::Koans::get_return_code()); 
}


sub about_until {
    # about_until()
    
    fail('about_until() has not been written');
    
    return (Perl::Koans::get_return_code()); 
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
    
    $results += about_for();
    $results += about_while();
    $results += about_until();
    
    return ($results) ? bail($results) : $results;
}


1;
