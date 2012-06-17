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

package Perl::Koans::Perlvars;
use warnings;

use lib './lib';
use Perl::Koans;

################
# your code goes below this line

# TODO cover %SIG

sub about_envvars {
    # about_envvars() -- this might not belong here, also: what other tests can i run?
    
    is ($ENV{HOME}, __, '$ENV{key} is the environment value \'key\''); # note that changes here only affect your script and any forked processes    
    
    return (Perl::Koans::get_return_code());
}

sub about_inc {
    # about_inc() -- coverage of @INC and %INC
    
    # @INC stores the paths Perl will look in when use/require is called
    printf('@INC: %s%s', @INC, '\n');
    is ($INC[-1], __, 'the last element of @INC is the working directory'); # TODO true, but unhelpful
    is ($INC[0],  __, 'if $ENV{PERL5LIB} is set, the values are prepended to @INC'); # see above
    
    # %INC stores the modules currently being used by Perl (package => full_file_path)
    print "\%INC:\n";
    for my $package (sort keys %INC) {
        printf("%s\t=>%s", $package, $INC{$package});
    }
    
    is ($INC{__}, '/usr/share/perl/5.10/Autoloader.pm', 'use %INC to find out which specific libraries you are using'); # TODO this test isnt any good.. what can we do here?

    return (Perl::Koans::get_return_code());
}

sub about_perlvars {
    # about_perlvars() 
    
    is ($^O, __, '$^O is an operating system identifier'); # linux/solaris/MSWin32/darwin
    is ($<,  __, '$< is the UID of this process');
    is ($?,  __, '$? is the exit/return code from the last operation'); # TODO this is not a great hint
    is ($0,  __, '$0 is the relative path/filename for the calling script/module'); # TODO this hint could be better
    is ($/,  __, '$/ is the line separator used by Perl: \r\n or \n'); # TODO should we mention when it's useful to change this?
    is ($|,  __, '$| controls flushing, default is 0, but if nonzero, wil flush after every write and print'); # TODO better hint
    
    for (5..10) { 
        is ($_, __, '$_ is the default variable in Perl'); # TODO yes, this is true -- but not that helpful
        last;
    }
    
    my $results = unlink('/tmp/this_file_does_not_exist');
    is ($!, __, '$! holds the error message from a function call');
    
    eval {
        my $foo = 1 / 0;
    }; # more coverage in about_exceptions.pl
    
    is ($@, __, '$@ holds the fatal error message (if any) from an eval block');
    
    open (my $fh, '<', $0); # bad form, always check $!
    while (<$fh>) {
        is ($., __, '$. is the current line number for the last filehandle accessed');
        last; # TODO i know, this test kind of sucks. but $. is really cool, i just don't know how better to reference it
    }
    
    # how do we handle tests whose results will change with each execution?
    is ($$,  __, '$$ is the PID of the Perl running this script');
    is ($^T, __, '$^T is the number of seconds since epoch when script started'); # hey, i learned something today!
    
    return (Perl::Koans::get_return_code());
}

sub about_parameters {
    # about_parameters() - discussion of @_, this function is called with ('foo', 'bar', 'baz')
    
	# TODO add example using $#_, cover pss-by-reference here?
    my $first = shift @_;
    is ($first, __, 'shift removes and returns the first element in the array it is called against'); # TODO better hint
    
    my $second = shift;
    is ($second, __, 'shift operates on the default array if none is specified');

	my @foo = (3, 2, 1);
	my $specified = shift @foo;
	is ($specified, __, 'shift operates on the array specified'); 

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
    
    $results += about_envvars();
    $results += about_inc();
    $results += about_perlvars();
    $results += about_parameters('foo', 'bar', 'baz');
    
    return ($results) ? bail($results) : $results;
}


1;
