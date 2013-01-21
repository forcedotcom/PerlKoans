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

package Perl::Koans::Scope;
use warnings;

use lib './lib';
use Perl::Koans;

our $TEST = 1;

################
# your code goes below this line

sub about_scope {
    # about_scope()
    
    my $foo = 100;
    my $bar = 200;
    
    is ($foo, __, 'use the most closely scoped variable -- part 1');
    {
        my $foo = 10;
        
        is ($foo, __, 'use the most closely scoped variable -- part 2');
        is ($bar, __, 'use the most closely scoped variable -- part 3');
        
    }

    is ($foo, __, 'use the most closely scoped variable -- part 4');
    
    
    for (my $foo = 0; $foo < 10; $foo++) {
        isnt($foo, __, 'use the most closely scoped variable -- part 5');
    }
    
    is ($foo, __, 'use the most closely scoped variable -- part 6');
    
    my $baz = 300;
    for ($baz = 0; $baz < 10; $baz++) {
        isnt ($baz, __, 'use the most closely scoped variable -- part 7');
    }
    
    is ($baz, __, 'use the most closely scoped variable -- part 8');
        
    return (Perl::Koans::get_return_code()); 
}

sub about_local {
    # about_local() - allows you to modify variables for the current block
    
    is ($TEST, __, 'unmodified package variable -- part 1');
    
    {   
        local $TEST = 100;
        
        is ($TEST, __, 'locally modified package variable');
    }
    
    is ($TEST, __, 'unmodified package variable -- part 2');
    
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
    $results += about_scope();
    $results += about_local();
    
    ## record results somewhere in Perl::Koans namespace
    return ($results) ? bail($results) : $results;
}


1;
