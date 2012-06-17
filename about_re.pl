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

package Perl::Koans::RE;
use warnings;

use lib './lib';
use Perl::Koans;

################
# your code goes below this line

# for a more complete tour of regular expressions in Perl, see:
#   <take links from Perl101.pptx>
#   http://perldoc.perl.org/perlre

    
my $string = 'Never gonna give you up, never gonna let you down, never gonna run around and desert you, never gonna make you cry'; # www.youtube.com/watch?v=dQw4w9WgXcQ
my $mixed  = 'Jenny, I got your number, I need to make you mine. Jenny, don\'t change you number: 867-5309';

sub about_character_classes {
	# about_character_classes()
    # character classes
    like (! $string, qr/\w/, '\w matches word characters: a..z 0..9 _');
    like ($string,   qr/__/, '\d matches digit characters: 0..9');
    like ($string,   qr/__/, '\s matches space characters: \n \r \t literal space');
    like ($string,   qr/__/, '. matches any character'); # it's not really a character class, but need to cover it somewhere
    
    like (__, qr/\w\d/,   'without any quantifiers, match only succeeds if <write something better>'); # TODO or should we wait to do this until after quantifiers?
    like (__, qr/\w\w\w/, 'without any quantifiers, match only succeeds if -- part 2');
    
    # 'negative' character classes
    like ($string, qr/__/, '\W matches non-word characters');
    like ($string, qr/__/, '\D matches non-digit characters');
    like ($string, qr/__/, '\S matches non-space characters');
    
    like (__, qr/\W\w\S\s\D/, 'without any quantifiers, match only succeeds if -- part 3');
    like (__, qr/\S\S\S/, 'without any quantifiers, match only succeeds if -- part 4');    
    
    return (Perl::Koans::get_return_code());
}

sub about_anchors {
    # about_anchors()

    like (! $string, qr/^Never/, '^ is an anchor to the beginning of the string');
    like ($string,   qr/__/,     '$ is an anchor to the end of the string');
    
    like (__, qr/^foo$/,   'both ^ and $ can be specified');
    like (__, qr/gonna$/,  '$ is an anchor to the end of the string - part 2');
    like (__, qr/^\d\d\d/, '^ is an anchor to the beginning of the string -- part 2');

    return (Perl::Koans::get_return_code());
}

sub about_quantifiers {
    # about_quantifiers()

    like (! $string, qr/\w*/, '* matches 0, or as many as possible repititions');
    like ($string,   qr/__/,  '+ matches 1, and as many as possible repititions');
    like ($string,   qr/__/,  '? matches 0 or 1');
    like ($string,   qr/__/,  '*? matches 0 or as few as possibile repititions');
    like ($string,   qr/__/,  '+? matches 1 or as few as possibile repititions');
    like ($string,   qr/__/,  '++ matches 1 as many <search for possessive matches>');
    
    # we need some better/more examples here
    like (__, qr/\d*\w/,       'a hint here kind of defeats the purpose');
    like (__, qr/\w?\d\S*\d$/, 'a hint here kind of defeats the purpose -- part 2');
    like (__, qr/^\S*?\d+\w/,  'a hint here kind of defeats the purpose -- part 3');
    
    like (! $string, qr/\w{1}/,   '{n} matches exactly n repititions');
    like ($string,   qr/\w{2,3}/, '{n1,n2} matches between n1 and n2 repititions');
    like ($string,   qr/\w{4,}/,  '{n,} matches at least n repititions');
    
    return (Perl::Koans::get_return_code());
}

sub about_modifiers {
    # about_modifiers() - covering i, g, x -- m, s in rev2
    
    # need to have some explanation about why it's good to know both ways?
    like (! $string, qr/^never/i,     'i modifies the RE to be case insensitive');
    like (! $string, qr/(?:i)^never/, 'i modifies the RE to be case insensitive -- part 2');

    my @array = $string =~ /up/g;
    is ($#array,          __, 'g modifies the RE engine to return all matches');
    is_deeply (\@array,   __, 'g modifies the RE engine to return all matches -- part 2');
    is ($string =~ /up/g, __, 'g modifies the RE engine to return all matches -- part 3'); # g doesn't do change anything in scalar context -- why doesn't it return the count?
    
    # TODO are these the right examples? or should we break down MAC / IP address validation?
    my $nasty_re = qr/^\d{3}-\d{4,}$/;
    
    my $nice_re = qr/
        ^      # matching beginning of string anchor
        \d{3}  # followed by 3 digits
        -      # then a dash
        \d{4,} # at least 4 digits
        $      # end of string
    /x;
    
    like (__, $nasty_re, 'x modifies the RE engine to ignore whitespace and turns the octothorpe into a metacharacter');
    
    return (Perl::Koans::get_return_code());
}

sub about_grouping {
    # about_grouping() -- capturing, non-capturing, alternation, bracket character classes, lookbacks
    
    # alternation
    like (! $string, qr/never|always/i, '| is the alternation character'); # TODO write better hints
    
    # capturing
    if ($string =~ qr/(\w*?)/) {
        is ($1, __, '$1 contains the first captured match'); # TODO write better hints
    }
    
    if ('abcdefghijklmnop' =~ qr/(\w)(\w)(\w)(\w)(\w)(\w)(\w)(\w)(\w)/) {
        is ($9, __, '$9 contains the ninth captured match');
    }
    
    # bracketed character classes
    like ('0a8d120462fa', qr/[0-9a-d]*/, '[ ] specifies a character class'); # TODO is this too obscure?
    
    # lookbacks
    
    fail('about_grouping() is not yet complete');
    
    return (Perl::Koans::get_return_code());
}

sub about_substitution {
    # about_substitution() -- s///, tr///
    
    fail('about_substitution() is not yet written');
    
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
    
    $results += about_character_classes();
    $results += about_anchors();
    $results += about_quantifiers();
    $results += about_modifiers();
    $results += about_grouping();
    $results += about_substitution();
    
    return ($results) ? bail($results) : $results;
}


1;
