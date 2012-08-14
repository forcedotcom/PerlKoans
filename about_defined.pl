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

package Perl::Koans::Defined;
use warnings qw(io severe);

use lib './lib';
use Perl::Koans;

################
# your code goes below this line

sub about_defined {
    # about_defined() -- defined is any value except undef
    my @foo = (1, -2 , 0);
    
    is (defined $foo[0], 0, 'a positive integer is defined');
    is (defined $foo[1], 0, 'a negative integer is defined');
    is (defined $foo[2], 0, 'even 0 is defined');
    
    my $str;
    
    is (defined $str, __, 'declared variables initialize to undef');
    
    my @bar;
    
    is (defined @bar,  __, 'declared variables initialize to undef -- part 2');
    is (defined $#bar, __, 'declared variables initialize to undef -- part 3');
    
    @bar = (27, 42, undef);
    is (defined $bar[__],   __, '27 and 42 are defined');
    is (! defined $bar[__], __, 'undef is not defined');
    
    return (Perl::Koans::get_return_code()); 
}

sub about_undef {
    # about_false() -- false is 0 and undef
    my $foo;
    
    # for many intents and purposes, Perl defines true as '1' and false as '' .
    # functions like 'defined' and 'exists' use this concept of truthiness
    is (defined __, '', 'undef is not defined'); 
    
    is (defined $foo, __, 'declared variables that have not been assigned are undef');
    
    return (Perl::Koans::get_return_code()); 
}

sub about_exists {
    # about_exists() -- similar to defined(), but exists() reports whether a particular hash key is present
    # not making mention of exists ability to look at arrays, because it is deprecated/not that useful
    my %hash = (
        foo => 'bar',
    );
    
    $hash{fizz} = 'bang';
    
    is (exists $hash{key}, 1, 'an empty string is returned when the key doesn\'t exist');
    
    $hash{key} = 'board';
    
    is (exists $hash{key}, '', '1 is returned when the key exists');
    
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
    $results += about_defined();
    $results += about_undef();
    $results += about_exists();
    
    return ($results) ? bail($results) : $results;
}


1;
