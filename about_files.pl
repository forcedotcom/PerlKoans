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

package Perl::Koans::Files;
use warnings;

use lib './lib';
use Perl::Koans;

################
# your code goes below this line

sub about_file_tests {
    # about_file_tests() -- http://perldoc.perl.org/perlfunc.html#Alphabetical-Listing-of-Perl-Functions has the full list (just look at those prefixed with -)
    
    my %files = (
        does_not_exist => 'this file does not exist',
        readable       => 'road_to_illumination.pl',
        not_executable => 'about_files.pl',
        owned          => 'about_time.pl', # it doesn't matter, any file will work
        this_is_a_dir  => 'lib',
        file_exists    => 'about_math.pl',
        empty          => '',
        not_a_link     => 'about_io.pl',
        
    );
    
    # TODO is it ok to not cover the 'real uid/gid' cases? personally, i've never used anything except effective
    is (-e $files{file_exists},    __, "-e file exists");
    is (-f $files{does_not_exist}, __, "-f file is a file");
    is (-d $files{this_is_a_dir},  __, "-d file is a directory");
    is (-r $files{readable},       __, "-r file is readable by effective UID/GID"); 
    is (-x $files{not_executable}, __, "-x file is executable by effective UID/GID");
    is (-o $files{owned},          __, "-o file is owned by effective UID/GID");
    is (-z $files{empty},          __, "-z file has size of zero");
    is (-l $files{not_a_link},     __, "-l file is a symbolic link");
    
    return (Perl::Koans::get_return_code());
}

sub about_stat {
    # stat -- http://perldoc.perl.org/functions/stat.html
    
    # create a file so we can do something
    my $filename = 'test.txt';
    open (my $fh, '>', $filename) or die sprintf('DIE:: unable to open [%s] for writing: %s', $filename, $!);
    print $fh "this is just a test\n";
    close ($fh);
    
    my @stat = stat($filename);
    is ($stat[4],  __, "the 4th index of stat is UID of file owner");
    is ($stat[5],  __, "the 5th index of stat is GID of file owner");
    is (__,        21, "the 7th index of stat is file size");
    is ($stat[8],  __, "the 8th index of stat is last access time since epoch");
    is ($stat[9],  __, "the 9th index of stat is last modify time since epoch");
    is ($stat[10], __, "the 10th index of stat is inode change time since epoch");
    
    # whenever an operation can fail, you should provide some 'error handling', see about_exceptions.pl for more
    unlink($filename) if -f $filename; 
    
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
    
    $results += about_file_tests();
    $results += about_stat();
    
    return ($results) ? bail($results) : $results;
}


1;
