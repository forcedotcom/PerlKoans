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

package Perl::Koans::Truth;
use warnings;

use lib './lib';
use Perl::Koans;

################
# your code goes below this line

my $true  = 1; 
my $false = 0; 

sub about_true {
    # about_true() -- true is any value except 0 and undef
    my @foo = (1,2,3);
    
    ok ('', 'a positive integer is true');
    ok ('', 'a negative integer is true');
    ok ('', 'an array in scalar context is true'); # see about_context.pl for more information
    
    if ($true) {
        ok (0, '0 is not true');
        ok (undef, 'undef is not true');
    }
    
    return (Perl::Koans::get_return_code()); 
}

sub about_false {
    # about_false() -- false is 0 and undef
    
    if (__) {
        fail('don\'t go here'); # or "don't go here"
    } else {
        ok (! __, 'undef and 0 are both false');
    }
        
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
    $results += about_true();
    $results += about_false();
    
    return ($results) ? bail($results) : $results;
}


1;
