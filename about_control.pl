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

package Perl::Koans::Control;
# TODO add: caller

use lib './lib';
use Perl::Koans;

################
# your code goes below this line

sub about_if {
    # about_if() - pruned list of allowed comparators in precedence order:
    #   ++ --
    #	**
    #	! ~                         ! negates result, ~ specifies a matching operation
    #	=~ !~
    #	* / % x
    #	+ - .
    #	<< >>
    #	< > <= >= lt gt le ge
    #	== != <=> eq ne cmp ~~      == and != force numeric comparison, while eq and ne force string comparison
    #	&
    #	| ^
    #	&&                          && is a logical and
    #	|| //                       || is a logical or, // is a defined-or (Perl 5.10+)
    #	..  ...
    #	= += -= *= etc.
    #	not
    #	and
    #	or xor
    
    # complete list: http://perldoc.perl.org/perlop.html#Operator-Precedence-and-Associativity
    
    # other notes:
    #   defined         1 or '' if operand is undef
    #   exists          1 or '' if hash key/array ref index is populated
    #   ()              just like algebra, parentheses are used to control order of operations (TODO decide how much we want to talk about capture groups, etc)
    
    # chaining comparisons, support shortcircuiting

    my $foo = 10;
    my $bar = 5;
    
    my @baz = (1, 2, 3, undef, 5);
    my %fizzy = ( zero => 0, one => 1, two => 2, three => 3);
    
    if ($foo == $bar) {
        pass('== forces numeric comparison'); 
    } else {
        fail('don\'t go here');
    }
    
    if ($foo == __) {
        pass('== forces numeric comparison -- part 2'); 
    } else {
        fail('don\'t go here');
    } 
    
    if (! defined __) {
        pass('3rd index of \@baz is undef'); 
    } else {
        fail('don\'t go here');
    }
    
    if ($fizzy{zero}) {
        pass('existence does not imply truthiness');
    } else {
        fail('don\'t go here');
    }
    
    if ($foo == $bar and $fizzy{one} <= 1) {
       pass('chaining'); 
    } else {
        fail('chaining');
    }
    
    # Perl uses 'short circuiting' to run as few tests as possible in a compound if statement
    # short circuiting occurs:
    #  if 'and' or '&&', any failed test
    #  if 'or' or '||', any successful test
    if ($fizzy{__} == 1 and $baz[2] == 2) {
        fail('short circuiting on and');
    }
    
    if ($fizzy{__} == 3 or $fizzy{zero} == 0) {
        pass('short circuiting on or');
    } else {
        fail('don\'t go here');
    }
    
    return (Perl::Koans::get_return_code()); 
}


sub about_else {
    # about_else() - else and elsif
    
    my $true  = 1;  
    my $false = 0;
    
    my $testname = 'else blocks are run when all if/elsif statements are false'; 
    
    if (__) {
        pass($testname);
    } else {
        fail($testname);
    }
    
    my $min = 10;
    my $mid = 15;
    my $max = 20;
    
    $testname = 'elsif tests are run top to bottom, and their block executes the first test that evaluates to true'; 
    if ($min < __) {
        fail($testname);
    } elsif ($max > __) {
        pass($testname);
    } else {
        fail($testname);
    }
    
    return (Perl::Koans::get_return_code()); 
}

sub about_unless {
    # about_unless() - the converse of if(), should be used only when it clarifies your intentions
    
    my $true  = 1;
    my $false = 0;
    
    my $testname = 'unless is the converse of if';
    
    unless ($true) {
        pass($testname);
    }
    
    unless ($true > $false) {
        fail($testname);
    } else {
        pass($testname);
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
    
    $results += about_if();
    $results += about_else();
    $results += about_unless();
    
    return ($results) ? bail($results) : $results;
}


1;
