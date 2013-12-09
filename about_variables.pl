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

package Perl::Koans::Variables;
use warnings;

use lib './lib';
use Perl::Koans;

## TODO -- are we breaking these methods up fine enough? e.g. about_scalar() vs. about_scalar_assignment(), about_scalar_interpolation()

# TODO add delete() function


################
# your code goes below this line

sub about_scalar {
    # about_scalar() - assignment / interpolation 
    # 
    my $foo = __;
    is ($foo, 'bar', 'assign a string to a scalar');
    
    my $bar = __;
    is ($foo, $bar, 'assign a scalar to another scalar');
    
    my $baz = __;
    is ($baz, "isn't", 'assign a string to a scalar, embedding a single quote');
    
    my $xyzzy = __;
    is ($xyzzy, 'xyzzy is not bar', 'interpolate a variable into a string'); # no cheating!
    
    #fail('expand interpolation coverage to include q// qq// qw//');
    
    return (Perl::Koans::get_return_code()); 
}

sub about_array {
    # about_array() - assignment / push-pop / 0based / references / index vs. count
    
    my @num = (1, 2, 3, 4);
    my @chr = ('a', 'b', 'c', 'd');
    my @mix = (@num, @chr);
    
    # to access array elements, use [ ]
    is ($num[0], __, 'array indexes are 0 based');
    is ($num[-1], __, 'array indexes can also be relative');
    
    my $character = pop(@chr);
    is ($character, __, 'pop returns elements in LIFO order');
    
    push (@chr, 'e');
    is (__, 'e', 'push pushes elements to the end of an array');
    
    is ($#foo,       __, 'on an undefined array, index count is -1');
    is (scalar @foo, __, 'on an undefined array, scalar context is 0');
    
    is ($#mix,       __, '$#array gives 0 based count, useful for loops');
    is (scalar @mix, __, 'in a scalar context, we get the human-friendly count');
    
    ## references are created by placing a \ in front of an array or hash name    
    my $chr_ref  = \@chr;
    my @separate = (\@num, $chr_ref);
    
    is ($#mix,          __, 'there are 8 elements in the array'); # TODO need a better hint here
    is (scalar @separate, __, 'the index count is 2'); # TODO need a better hint here
    is ($chr_ref->[0],    __, 'array reference indexes are also 0 based');
    is (__, ['a', 'b', 'c', 'd'] , 'arrays references can be defined directly with brackets');

    $chr_ref->[5] = 'f';
    is (__, $chr_ref->[4], 'autovivification in an array yields undef elements');
    
    my @unsorted = (5, 3, 1, 4, 2);
    my @sorted   = sort @unsorted;
    is ([1, 2, 3, 4, 5], __, 'sort arrays'); # TODO need a better hint here
    
    my @range = 0..10;
    is (\@range, __, '.. is the range operator, provides list of intermediate values');
    
    @range = 5..0;
    is (\@range, __, '.. is the range operator, provides list of intermediate values -- part 2'); # why doesn't this work? how could it be rewritten?
    
    @range = 'a'..'d';
    is (\@range, __, '.. is the range operator, provides list of intermediate values -- part 3');
    
    @range = 'a'..'Z';
    is (\@range, __, '.. is the range operator, provides list of intermdiate values -- part 4'); # is this what you expected?
    
    return (Perl::Koans::get_return_code()); 
}

sub about_hash {
    # about_hash() - assignment / keys-values / references
    
    # hashes are really just lists under the covers, so use () to define them
    my %colors = (
        red   => '#FF0000',
        green => '#3ADF00',
        blue  => '#0101DF',
    );

    my %special = (
        'need_to_quote_keys_if'            => 1,
        '_if_they start with ! [-_a-zA-Z]' => 2,
        'or_contain ! \w'                  => 3, 
    );
    
    # to access hash keys, use { }
    is ($colors{red}, __, 'pull values from hashes using keys');
    is ('#3ADF00', __, 'pull values from hashes using keys - part 2');
    
    is (keys(%colors), __, 'keys() pulls lists of keys from hashes');
    is (__, \('#FF0000', '#3ADF00', '#0101DF'), 'values() pulls lists of values from hashes');
    
    
    my %nested = (
        1 => { # braces enclose hashes inside hashes # TODO this isn't the entire picture, but it's correct enough for now.. agree? same down in %mixed_nest
            English => 'one',
            Spanish => 'uno',
        }, 
        
        2 => {
            English => 'two',
            Spanish => 'dos',
        }, 
        
        3 => {
            English => 'three', # trailing comma required
            Spanish => 'tres',  # trailing comma suggested for future growth 
        }, # trailing comma suggested for future growth 
    );
    
    my %mixed_nest = (
        4 => [ 'four', 'quatro', ], # brackets enclose arrays inside hashes
        5 => [ 'five', 'cinco', ],
        
        sum => 9, # this is just a scalar
        
        hash => {
            languages => [ 'English', 'Spanish', ],
            another_way => [ keys %{$nested{1}} ], 
        },
    );

    is ($nested{1}{English}, __, "use the sigil that represents the return type you want"); # TODO better hint here, tie it up with braces vs. brackets
    is (__, 'tres', "use the sigil that represents the return type you want - part 2");

    my @fours = @{ $mixed_nest{4} }; # space is anything but the f-word that rubyists can't stop saying
    is ($fours[0], __, "use the sigil that represents the return type you want - part 3");
    is (__, 'quatro', "use the sigil that represents the return type you want - part 4");

    fail('about_hashes() is missing the reference section');
    
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
    $results += about_scalar();
    $results += about_array();
    $results += about_hash();
    
    return ($results) ? bail($results) : $results;
}


1;
