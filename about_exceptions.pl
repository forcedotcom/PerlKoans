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

package Perl::Koans::Exceptions;
use warnings;

use lib './lib';
use Perl::Koans;

use Socket;

################
# your code goes below this line

sub about_errors {
    # about_errors() -- $! / or handling

    my $results;
    
    $results = open(my $fh, '>', '/etc/passwd');
    
    is   ($results, __, 'empty strings are returned for failed operations'); 
    like ($!,   qr/__/, '$! is populated with the error message for failed operations'); 
    
    mkdir('/root/foo') or do {
        # no one is running the koans as root.. right?
        fail('empty strings are returned for failed operations');
    };

    return (Perl::Koans::get_return_code()); 
}

sub about_eval {
    # about_eval() -- eval {}; if $@ // eval {} or do {}

    my $results;
    
    $results = eval {
        4 / 0;
    };
    
    is   ($results, __, 'eval returns undef if fatal error hit');
    like ($@,   qr/__/, '$@ is populated with the fatal error message');
    
    # ht to markw
    my $error = eval {
        my $msg = 'the world is broken!';
        
        return $msg unless 1 == __;
        return $msg unless 5 > 10;
        return $msg unless -f '/tmp/foo.bar';
        return $msg unless __ =~ /P.*l/i;
        
        return undef;
    };
    
    if ($error) {
        fail('fix tests in eval block'); 
    }
    
    return (Perl::Koans::get_return_code());
}

sub about_try_tiny {
    # about_try_tiny() -- only dependency is Test::More
    
    unless (Test::More::use_ok('Try::Tiny')) {
        # alternatively, you can just change the next line to 'pass' to skip Try::Tiny coverage
        fail('please install Try::Tiny from CPAN to continue');
    } else {
        use Try::Tiny;
    }
    
    try {
        print "foobar\n";
        
        my $ip_address = ''; # really ,this should be inet_aton(<hostname>)
        my $hostname   = inet_ntoa($ip_address);
        
        print "this code will never be executed\n";
        
    } catch {
        
        print "caught fatal error\n";
        like ($_, qr/__/, 'Try::Tiny stores the exception text in $_'); # not $@
    };
    
    try {
        print "fizzbang\n";
        
        my $i = 1;
        my $result;
        
        # if you are running more than one potentially fatal command,
        # it sometimes makes more sense to wrap the operations in eval/try
        # rather than 'or die' on each line
        
        $result = 10 / $i;
        $i--;        
        $result = 10 / $i;
        
        print "this code will never be executed\n";
        
    } catch {
        
        # TODO this should be made more different 
        print "caught fatal error\n";
        like ($_, qr/__/, 'Try::Tiny stores the exception text in $_');
    } finally {
        
        fail('finally blocks are always executed');
        
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
    
    $results += about_errors();
    $results += about_eval();
    $results += about_try_tiny();
    
    return ($results) ? bail($results) : $results;
}


1;
