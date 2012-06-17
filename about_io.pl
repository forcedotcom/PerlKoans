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

package Perl::Koans::IO;
use warnings;

use lib './lib';
use Perl::Koans;

################
# your code goes below this line

# skipping: dbmclose, dbmopen, format, syscall

sub about_std_io {
    # about_std_io() - STDOUT/STDERR/STDIN, print, printf, say
    # http://en.wikipedia.org/wiki/Standard_streams
    
    print "test\n";
    print STDOUT "test\n";
    is (1, __, 'print() without a filehandle will print to STDOUT');
    
    print STDERR "fake ERROR!\n";
    warn "fake ERROR!\n";
    is (1, __, 'print() can also print to a stream');
    
    print "Please enter your name: ";
    my $name = <STDIN>;
    chomp($name); # chomp() modifies expr in place and removes trailing newlines
    
    is ($name, __, '<STDIN> returns keyboard input, including \n');
    
    # sprintf() and it's louder cousin printf() do what you'd expect coming from any other lanaguage
    # http://perldoc.perl.org/functions/sprintf.html
    my $change = sprintf('$5 less than $20 is %s%f', '$', 20 - 5);
    is ($change, __, 'sprintf() makes it easier to interpolate variables/data into strings - part 1');
    
    my $os     = sprintf('My operating system is %s', $^O); # more in about_perlvars.pl
    is ($os, __, 'sprintf() makes it easier to interpolate variables/data into strings - part 2');
    
    printf('
           decimal:                   %d
           unsigned decimal:          %u
           unsigned octal:            %o
           unsigned hex:              %x
           floating point scientific: %e
           floating point decimal:    %f
           floating point in e/f:     %g',
           
           10, 10, 10, 10, 10, 10, 10 # using the same number repeatedly to show that printf() doesn't change the value, just how it is represented
    );     
    
    
    return (Perl::Koans::get_return_code()); 
}

sub about_filehandle_io {
    # about_filehandle_io() - open()/close()/ $fh vs FILE, read, eof, seek(), write
    # sysread(), sysseek(), syswrite(), binmode(), fileno(), flock(), getc, select(), truncate, tell
    
    pass('about_filehandle_io() is slated for the next release');
    
    return (Perl::Koans::get_return_code());
}

sub about_dirhandle_io {
    # about_dirhandle_io() - opendir()/readdir()/closedir()/seekdir()/telldir()/rewinddir()
    
    pass('about_dirhandle_io() is slated for the next release');
    
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
    
    $results += about_std_io();
    $results += about_filehandle_io();
    $results += about_dirhandle_io();
    
    return ($results) ? bail($results) : $results;
}


1;
