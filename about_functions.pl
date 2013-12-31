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

package Perl::Koans::Functions;
use warnings;

use Cwd;

use lib './lib';
use Perl::Koans;

################
# your code goes below this line

# a complete list of the Perl built-in functions:  http://perldoc.perl.org/perlfunc.html
#                                                  http://perldoc.perl.org/index-functions.html

sub about_scalar_functions {
    # TODO crypt and pack for a future revision
    
    my $line = "this is a test\n";
    my $str  = 'so is this';
    
    is (chomp($line), __, 'chomp() removes the last character of a string if it is \n');
    is (chop($str),   __, 'chop() removes the last character of a string');
    
    my $character = 'G';
    
    is (ord($character), __, 'ord() returns the numeric value of a single character');
    is (chr(__), $character, 'chr() returns the character value of a number in ASCII/Unicode');

    is (uc($line),      __, 'uc() returns expr with all a-z changed to A-Z'); 
    is (ucfirst($line), __, 'ucfirst() returns expr with first character a-z changed to A-Z');
    
    my $greatrunes = 'SORRY FOR THIS';
    is (lc($greatrunes),      __, 'lc() returns expr with all A-Z changed to a-z'); 
    is (lcfirst($greatrunes), __, 'lcfirst() does what you expect'); 
    
    is (length($str),       __, 'length() returns the number of characters in a string');
    is (index($str, 'is'),  __, 'index(string, substring) returns the initial first index for substring in string'); 
    is (rindex($str, 'is'), __, 'rindex(string, subtrstring) returns the final first index for substring in string');
    
    # substring has a couple call signatures
    is (substr($str, 6),    __, 'substr(string, offset) returns string after offset');
    is (substr($str, 3, 2), __, 'substr(string, offset, length) returns substring from string after offset of length');
    
    my $new_line = substr($line, 10, 4, uc('sparta!'));
    is ($new_line, __, 'substr(string, offset, length, replacement) - retuns modified string substituting the characters at offset+length with replacement');
    
    is (reverse($str), __, 'reverse() in a scalar context reverse the order of the characters in the string');
    
    return (Perl::Koans::get_return_code()); 
}

sub about_numeric_functions {
    #  about_numeric_functions()
    
    # commonly used numeric functions
    is (abs(-10),          __, 'abs() returns the absolute value of a number');
    is (sqrt(64),          __, 'sqrt() returns the square root of a number'); # more in about_math.pl
    
    is (hex('0xFF'),       __, 'hex() returns the decimal value of a hex number'); # this always trips people up, if you want to turn a decimal into a hex, use printf/sprintf/unpack    
    is (int(100.50),       __, 'int() returns an integer');
	
    is (oct(100),     __, 'oct(octal)  returns the corresponding value');
    is (oct(0xFF),    __, 'oct(hex)    returns the corresponding value');
    is (oct(0b11011), __, 'oct(binary) returns the corresponding value');
    
    # less-commonly used numeric functions
    my ($y, $x) = (5, 20);
    my $number  = 10;
    
    is (atan2($y, $x), __, 'atan2() returns the arctangent of Y/X');
    is (cos($number),  __, 'cos() returns the cosine of expr (radians)');
    is (sin($number),  __, 'sin() returns the sine of expr (radians)');
    is (exp($number),  __, 'exp() returns e to the power of expr');
    is (log($number),  __, 'log() returns the natural logarithm of expr');
    
    # random numbers
    my @colors = ('red', 'green', 'blue');
    
    is (rand(__) < 100,                  1, 'rand(max) returns a random fractional number less than max');
    is (int(rand(100)) < 100,           __, 'int() often wraps rand() to get whole numbers');
    isnt ($colors[int(rand($#colors))], __, 'putting it all together'); # TODO write a better hint here, but i mean for this to be complex
    
	# srand() is seed rand, not secure rand: http://perldoc.perl.org/functions/srand.html
    my $known_seed = 100;
	my $rando_seed = rand(1000);
	
	my ($first, $second, $third);
	
	srand($known_seed);
	$first = rand();
	
	srand($rando_seed);
	$second = rand();
	
	srand($known_seed);
	$third = rand();
	
	is   ($first, __, 'when reusing a seed, rand() is predictable');
	isnt ($first, __, 'when using a new seed, rand() is ~unpredicatable');
	
    return (Perl::Koans::get_return_code()); 

}

sub about_file_functions {
    #  about_file_functions()
    # skipping: chroot, fcntl, ioctl, sysopen, umask, utime

    my @dirs;
    
    if ($^O =~ /MSWin/i) {
        @dirs = ('c:\\', 'c:\temp\\');
    } else {
       @dirs = ('/tmp/', '/var/'); 
    }
    
    my $cwd  = Cwd::getcwd(); 
    
    is ($cwd, __, 'Cwd::getcwd() returns the current working directory');
    
    my @files = glob('*');
    
    is ($#files,   __, 'glob() returns a list of files/directories matching expr');
    is ($files[0], __, 'glob() returns a list of files/directories matching expr');
    
    my $chdir_result = chdir($dirs[0]);
    
    is ($chdir_result,   __, 'chdir() changes the current working directory');
    is (Cwd::getcwd(), $cwd, 'chdir() changes the current working directory -- part 2'); 
    
    my $filename = 'this_is_just_a_test.txt';
    
    open (my $fh, '>', $filename);
    if ($fh) {
        print $fh "so is this\n";
        close ($fh);
    } else {
        die sprintf("unable to create [%s] in [%s]", $filename, Cwd::getcwd());
    };
    
    my @stat = stat($filename); # more in about_files.pl
    if ($^O !~ /MSWin/i) {
        my $permissions = $stat[2] & 07777;
        my $owner_id    = $stat[4];
        my $owner_name  = (getpwuid($owner_id))[0]; 
        
        is ($permissions, __, 'stat() can be used to get file permissions');
        is ($owner_name,  __, 'stat() can be be used to get owner information');
        
        my $chmod_result = chmod('09999', $filename);
        
        is   ($chmod_result, __, 'chmod() returns 1 for a successful change'); 
        like (__,            $!, 'chmod() populates $! on error');
        
        my $new_uid = '';
        my $new_gid = '';
        
        isnt ($new_uid, __, 'administrative - please fill in a new valid UID, or -1 to leave unchanged');
        isnt ($new_gid, __, 'administrative - please fill in a new valid GID, or -1 to leave unchanged');
        
        my $chown_result = chown($new_uid, $new_gid, $filename);
        
        @stat = stat($filename);
        $permissions = $stat[2] & 07777;
        $owner_name  = (getpwuid(stat[4]))[0];
        
        is ($permissions, __, 'stat() can also be used to get file permissions -- part 2');
        is ($owner_name,  __, 'stat() can also be used to get owner information -- part 2');
    }
    
    # mkdir, opendir, rmdir
    my $new_dir = ($^O =~ /MSWin/i) ? sprintf('C:\Windows\Temp\fizzbang.%s', $$) : sprintf('/tmp/fizzbang.%s', $$); 
    
    if (-d $new_dir) {
        die "DIE:: a testing directory, [$new_dir], appears to already exist on your system";
    }
    
    my $mkdir_results = mkdir($new_dir);
    
    is ($mkdir_results, __, 'mkdir() does the same thing as its shell companion');
    is (-d $new_dir,    __, 'mkdir() does the same thing as its shell companion -- part 2');
    
    my $new_filename   = printf('%s/xyzzy.txt', $new_dir);
    my $rename_results = rename($filename, $new_filename);
    
	warn 'NOTE:: you cannot use rename() across drives on Windows' if $^O =~ /MSWin/i;
    is ($rename_results,  __, 'rename() is akin to move');
    is (-f $filename,     __, 'rename() is akin to move -- part 2');
    is (-f $new_filename, __, 'rename() is akin to move -- part 3');    
    
    # ok, back to the *dir
    opendir(my $dh, $new_dir);
    while (readdir($dh)) {
        next if $_ eq '.' or $_ eq '..'; # don't want symbolic dir links
        
        is ($_, __, 'readdir() returns all entries in a given directory');
        
        last;
    }
    closedir($dh);
    
    my $rmdir_results = rmdir($new_dir);
    
    is ($rmdir_results, __, 'rmdir() will only remove empty directories');
    is ($!,             __, 'rmdir() will only remove empty directories -- part 2');
    
    my $unlink_results = unlink($new_filename);
    is ($unlink_results,  __, 'unlink() removes a list of files');
    is (-f $new_filename, __, 'unlink() removes a list of files -- part 2');
    
    $rmdir_results = rmdir($new_dir);
    is ($rmdir_results, __, 'rmdir() will only remove empty directories -- part 3');
    
    if ($^O !~ /MSWin/i) {
        # links are weird on Windows
        my $link = '/tmp/test.lnk'; 
        my $link_results = link($0, $link);
        
        is (-f $link, __, 'link(src, dst) creates a hard link from src to dst'); # TODO potential issue here: when trying this on my wsl, i get:  'Invalid cross-device link', could be related to the software raid?
        
        my $sym_link = '/tmp/test_sym.lnk';
        my $sym_link_results = symlink($0, $sym_link);
        
        is (-f $sym_link, __, 'symlink(src, dst) creates a symbolic link from src to dst');
        
        my $read_link = readlink($sym_link);
        is (-f $read_link, __, 'readlink(sym_link) returns the relative path to the file it is linked to');
        
        # similar to stat(), covered in about_files.pl, lstat() gives information about the symbolic link -- not the file it points to
        my @lstat = lstat($sym_link);
        is ($stat[4],  __, "the 4th index of stat is UID of file owner");
        is ($stat[5],  __, "the 5th index of stat is GID of file owner");
        
        $unlink_results = unlink($link, $sym_link);
        is ($unlink_results, __, 'unlink(list) is not specific to links, acts on files');
        
    }
    
    chdir($cwd); # are you to good for your home?!
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
    
    $results += about_scalar_functions();
    $results += about_numeric_functions();
    $results += about_file_functions();
    
    return ($results) ? bail($results) : $results;
}


1;
