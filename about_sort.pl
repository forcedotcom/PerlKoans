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

package Perl::Koans::Sort;
use warnings;

use lib './lib';
use Perl::Koans;


################
# your code goes below this line

sub about_sort {
    # about_sort() - sort, reverse

    my @unsorted_nums  = (3, 1, 2);
    my @unsorted_chars = ('c', 'd', 'o');
    my @unsorted_mix   = ('a', 1, 'b', 2, 'c', 3);

    my @sorted_nums = sort @unsorted_nums;

    is_deeply (\@sorted_nums,          [1, 2, 3], 'sort(list) returns contents of list in ASCIIbetical order'); # TODO: where else do we need to replace is with is_deeply() ?, also need to overload this function in Perl::Koans 
    is_deeply ([sort @unsorted_chars], __, 'sort(list) returns contents of list in ASCIIbetical order -- part 2');
    is_deeply ([sort @unsorted_mix],   __, 'sort(list) returns contents of list in ASCIIbetical order -- part 3');
    
    my %h = (
        one   => 1,
        two   => 2,
        three => 3,
    );
    
    is_deeply ([sort keys %h],   __, 'sort(list) returns contents of list in ASCIIbetical order -- part 4');
    is_deeply ([sort values %h], __, 'sort(list) returns contents of list in ASCIIbetical order -- part 5');
    
    my @reversed_nums = reverse sort @unsorted_nums;
    is_deeply(\@reversed_nums, __, 'reverse(list) returns list in reverse order'); # TODO how to mention the difference between scalar and array context here? maybe it becomes a model in about_context.pl
    
    ## TODO, probably pull this, is a little advanced
    my @unsortable_array;
    my %phone_numbers = ( emergency => 911, operator => 0 );
    my %addresses     = ( work => '1 Market St' );
    
    push @unsortable_array, \%phone_numbers;
    push @unsortable_array, \%addresses;

    # TODO better comment / test name here
    is_deeply ([sort @unsortable_array], __, 'sort(list) requires that elements in list must be comparable');

    return (Perl::Koans::get_exit_code());
}

sub about_custom_sorts {
    # about_custom_sorts() - only covering inline functions
    
    my @array = ('01', 2, 3, 'a'..'c', 'D');
    is_deeply ([sort { $a cmp $b } @array], __, 'sort { } supports a -1|0|1 comparison block using $a, $b foreach in a list -- cmp is a string comparison'); # this is how Perl does sorting by default -- better hint here
    is_deeply ([sort { $a <=> $b } @array], __, 'sort { } supports a -1|0|1 comparison block using $a, $b foreach in a list -- <=> is a numeric comparison');
    
    fail("write some actually complete tests for custom sorting");
    
    # TODO finish this
    # a multilevel sort example? sort elements in an array according to their hash keys, and then their actual values
    # is_deeply ([], __, 'sort { } supports a -1|0|1 comparison block using $a, $b foreach in ')
    
    # (sort { $a <=> $b } @values )
    # (sort { $a <=> $b } keys %hash)
    # (sort { $hash{$a} <=> $hash{$b} } keys %hash)
    
    
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
    
    about_sort();
    about_custom_sorts();
    
    return ($results) ? bail($results) : $results;
}


1;
