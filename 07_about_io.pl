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
# TODO: add tie() in a future revision

sub about_std_io {
    # about_std_io() - STDOUT/STDERR/STDIN, print, printf, say
    # http://en.wikipedia.org/wiki/Standard_streams
    
    print "test\n";
    print STDOUT "test\n";
    is (1, __, 'print() without a filehandle/stream will print to STDOUT');
    
    print STDERR "fake ERROR!\n";
    warn "fake ERROR!\n"; # TODO not sure how to mention this properly
    is (1, __, 'print() can also print to a filehandle/stream');
    
    print "Please enter your name: ";
    
    my $name = <STDIN>;
    is ($name, __, '<STDIN> returns keyboard input, including \n');
    
    chomp($name);
    is ($name, __, 'chomp() modifies expr in place and removes trailing \n');
    
    # sprintf() and it's louder cousin printf() do what you'd expect coming from any other lanaguage
    # see `perldoc -f sprintf` or http://perldoc.perl.org/functions/sprintf.html for a complete list of modifiers
    my $change = sprintf("$5 less than $20 is %s%f", '$', 20 - 5);
    is ($change, __, 'sprintf() makes it easier to interpolate variables/data into strings - part 1');
    
    my $os     = sprintf('My operating system is %s', $^O); # more in about_perlvars.pl
    is ($os, __, 'sprintf() makes it easier to interpolate variables/data into strings - part 2');

	is (sprintf('%s', uc('foo')), __, 'sprintf() uses [%s] to format parameters as strings');
	is (sprintf('%i', 3.50),      __, 'sprintf() uses [%i] to format parameters as integers');
	is (sprintf('%x', 42),        __, 'sprintf() uses [%x] to format parameters as hex numbers');
	is (sprintf('%f', 27),        __, 'sprintf() uses [%f] to format parameters as floating point numbers');
	
	is (sprintf('%d, %f', 10**100, 10**199),                      __, 'sprintf() allows multiple, different modifiers');
	is (sprintf('http://%s:%s/%s', 'google.com', '80', 'search'), __, 'common usage of sprintf()');

    
    # TODO turn this into a test? i think it might be enough to just demonstrate it
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
    
    my %files = (
        in        => $Perl::Koans::WINDOWS ? sprintf('%s/system.ini', $ENV{WINDIR})          : '/etc/passwd', # need to confirm this file exists on Windows
        overwrite => $Perl::Koans::WINDOWS ? sprintf('%s/overwrite.%s.txt', $ENV{TMP}, time) : sprintf('/tmp/overwrite.%s', time), 
        append    => $Perl::Koans::WINDOWS ? sprintf('%s/append.%s.txt', $ENV{TMP}, time)    : sprintf('/tmp/append.%s', time),
    );
    
    ## to create a filehandle, use open(filehandle, direction, filename)
    open (my $in_fh,            '<',  $files{in});
    open (my $out_overwrite_fh, '>',  $files{overwrite});
    open (my $out_append_fh,    '>>', $files{append});
    
    ## to read contents from a filehandle, use $var = <$filehandle>, or while (<$filehandle>) { $line = $_ }
    my $in_file_as_scalar = <$in_fh>;
    my @in_file_as_array  = <$in_fh>;
    
    is (ref $in_file_as_scalar, __, 'reading a file into a scalar');
    is (ref \@in_file_as_array, __, 'reading a file into an array');
    
    is (join("\n", @in_file_as_array), __, 'reading a file into an array splits elements on \n');
    
    my $overwrite_before = get_contents($files{overwrite});
    my $append_before    = get_contents($files{append});
    
    ## to write contents out to a filehandle, use print $filehandle $contents
    print $out_overwrite_fh 'OVERWRITE';
    print $out_append_fh    'APPEND';
    
    ## file contents are not written until the filehandle is closed
    close ($in_fh);
    close ($out_overwrite_fh);
    close ($out_append_fh);
    
    my $overwrite_after = get_contents($files{overwrite});
    my $append_after    = get_contents($files{append});
    
    is ($overwrite_before eq $overwrite_after, __, 'overwrite file is different before/after');
    is ($append_before    eq $append_after,    __, 'append file is different before/after');
    
    like ($overwrite_after, qr/__/, 'overwrite file contains new content');
    like ($append_after,    qr/__/, 'append file contains new content');
    
    unlike (__, qr/OVERWRITE/i, 'original overwrite file contents do not contain new content');
    unlike (__, qr/APPEND/i,    'original append file contents do not contain new content');
    
    ## unlink our created files
    my @files = ($files{overwrite}, $files{append});
    
    for my $file (@files) {
        unlink($file) or warn sprintf('WARN:: unable to remove [%s]: %s', $file, $!);
    }
    
    return (Perl::Koans::get_return_code());
}

sub about_dirhandle_io {
    # about_dirhandle_io() - opendir()/readdir()/closedir()/seekdir()/telldir()/rewinddir()
    
    fail('about_dirhandle_io() is incomplete');
    
    my $dir = $Perl::Koans::WINDOWS ? $ENV{WINDIR} : '/tmp';
    
    ## opendir() is similar to open() except it operates on directories, not files, and as such has no mode -- read is implied
    opendir(my $dh, $dir) or fail(sprintf('unable to open dir [%s]: %s', $dir, $!));
    
    is (ref __, 'GLOB', 'dirhandles are GLOB reference types');
    
    ## readdir() is wantarray() sensitive:
    #   if you are assigning to a scalar, you get the next file/directory (not necessarily in alphabetical order)
    #   if you are assigning to an array, you get a list of the remaining files/directories in the top level dir
    
    my $first_file   = readdir($dh);
    my @dir_contents = readdir($dh);
    
    is   (-e $first_file, __, 'return from readdir() exists');
    isnt ($dir_contents[__], $first_file, 'a call to readdir() affects the next call to readdir()'); # TODO write a better hint here
    
    ## telldir() returns the current position in the directory a handle is pointed at
    my $telldir = telldir($dh);
    
    is ($telldir, __, 'readdir() counting is 1-based');

    readdir($dh);
    
    my $new_telldir = telldir($dh);
    
    is ($new_telldir, __, 'readdir() counting is 1-based, pt 2');

    ## seekdir() allows you to change the position a directory handle is pointed at
    seekdir($dh, 0);
    
    my $first_file_pt2 = readdir($dh);
    
    is ($first_file eq $first_file_pt2, __, 'seekdir() changes current position of a directory handle');
    
    ## rewinddir() is essentially a call to seekdir($dh, 0), and resets the position a directory handle is pointed at
    rewinddir($dh);
    
    my $first_file_pt3 = readdir($dh);
    
    is ($first_file_pt2 eq $first_file_pt3, __, 'rewinddir() resets current position of a directory handle to the beginning of the directory');

    ## closedir() is usually just a formality, technically returns true|undef, but if you fail to close a dir you opened, something strange is going on
    is (defined closedir($dh), __, '');
    
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

sub get_contents {
    # get_contents($file) - returns array/scalar based on wantarray(), or undef on error
    my ($ffp) = @_;
    
    return undef unless defined $ffp;
    return undef unless -r $ffp;
    
    open (my $fh, '<', $ffp) or return undef;
    
    if (wantarray()) {
        my $contents = <$fh>;
        return $contents;
    } else {
        my @contents = <$fh>;
        return @contents;
    }
    
    close ($fh);
    
    return undef;
}

1;
