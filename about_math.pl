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

package Perl::Koans::Math;
use warnings;

use lib './lib';
use Perl::Koans;

################
# your code goes below this line

sub about_math {
    # about_math() 
    # TODO break this up into distinct subs?
    
    # increment/decrement
    my $foo = 10;
    
    is ($foo++, __, "++ increments a variable by 1");
    is ($foo--, __, "-- decrements a variable by 1");
    
    my $bar = 20;
    
    $bar += 10;
    is ($bar, __, "+= increments and assigns");
    
    $bar -= 10;
    is ($bar, __, "-= decrements and assigns");
    
    $bar *= 2;
    is ($bar, __, "*= multiples and assigns");
    
    $bar /= 2;
    is ($bar, __, "/= divides and conquers"); # couldn't help myself. since this is rarely (if ever) used, not sure we should keep it
    
    # modulus
    my $baz = 100;
    is ($baz % 50, 0,  "% provides the modulus");
    is ($baz % 10, __, "% provides the modulus - part 2"); # TODO better hint
    
    my $even = __;
    my $odd  = __;
    is ($even % 2, 1, "modulus is often used to determine even/odd");
    is ($odd  % 2, 0, "modulus is often used to determine even/odd - part 2");
    
    # power of / sqrt
    my $base = 3;
    is ($base ** 2, _, "** raises first operand to second operand"); # TODO better hint
    is ($base ** __, 27, "** raises first operand to second operand - part 2");
    
    $base = 25;
    is (sqrt($base), __, "sqrt() gives the square root of the operand");
    is (__, 8, "sqrt() gives the square root of the operand -- part 2");
    
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
    
    $results += about_math();
    
    return ($results) ? bail($results) : $results;
}


1;
