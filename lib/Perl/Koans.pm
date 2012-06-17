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

package Perl::Koans;

use strict;
use warnings;

use Test::More import => ['!like', '!is', '!ok', '!fail', '!pass', '!is_deeply'];
use base 'Test::Builder::Module';

our $CLASS = __PACKAGE__; # this probably doesn't need to be our..
our $tb    = $CLASS->builder;

$tb->no_plan();  
$tb->level(2);  # this sets the caller() level so we get the failure from about_*, not __PACKAGE__

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT = qw(is is_deeply like ok fail pass bail get_return_code print_illumination);
our @EXPORT_OK = qw(display_progress);

sub is {
    my ($got, $expected, $name) = @_;
    Test::More::is($got, $expected, $name) or bail(get_return_code());
}

sub is_deeply {
    my ($got, $expected, $name) = @_;
    Test::More::is_deeply($got, $expected, $name) or bail(get_return_code());
}

sub like {
    my ($got, $expected, $name) = @_;
    Test::More::like($got, $expected, $name) or bail(get_return_code());
}

sub ok {
    my ($got, $name) = @_;
    Test::More::ok($got, $name) or bail(get_return_code());
}

sub fail {
    my $name = shift;
    Test::More::fail($name);
    bail(get_return_code());
}

sub pass {
    my $name = shift;
    Test::More::pass($name);
}

sub bail {
    # bail($e) - exits the road
    my $e = shift;
  
    my @sayings = (
        # http://www.squidoo.com/zen-quotes
        'the journey of a thousand miles must begin with a single step',
        'do not speak - unless it improves on the silence',
        'the obstacle is the path',
        'when you get to the top of the mountain, keep climbing',
        'he who asks a question is a fool for a minute; he who does not remains a fool forever',
        'before enlightenment: chop wood, carry water. after enlightment: chop wood, carry water',
    );

    display_progress($e);
    $tb->BAIL_OUT($sayings[int(rand($#sayings))]);
    exit;
}

sub get_return_code {
    # get_return_code() - returns 0 if all tests pass, N otherwise -- where N is number of tests that have run

    my $passed = 0;

    for my $result (@{$tb->{Test_Results}}) {
        $passed++ if $result->{actual_ok};
    }

    my $tests_run = $#{$tb->{Test_Results}} + 1;

    return ($passed == $tests_run) ? 0 : $tests_run;
}

sub determine_test_count {
    my $count = 0;
    my $test_functions = qr/^\s*(is|is_deeply|like|ok|pass)\s*\(/i; 
    
	my @files = grep { $_ =~ /about_.*\.pl/ } values %INC;
	push @files, $0 if $#files == -1;

    for my $file (@files) {
        open (my $fh, '<', $file) or next;
        
        while (<$fh>) {
            $count++ if $_ =~ $test_functions; 
        }
        
        close($fh);
    }
    
    return ($count - $#files); # we need to subtract the tests that are in road_to_illumination.pl 
}   

sub display_progress {
    # display_progress($tests_completed) - prints an ASCII graph based on number of tests done / remaining
    my $completed  = shift;
       $completed  = 0 unless $completed;
    my $total      = determine_test_count();
    my $max_length = 50;  # hah, string length, screen width
    
    my $done = int(($completed / $total)  * $max_length);
    my $tbd  = ($max_length - $done);
    
    my $output = 'X' x $done;
    $output   .= '_' x $tbd;
    
    print "$output $completed/$total\n";
}

sub print_illumination {
    # pure cheese.

    print <<HERE
          `--:-...`````````````````....           
        -::......``````````````````````.-.        
      -/-.......``````````````````````````-.      
    ./---.......````````````       `````````-.    
   ::----......````````````           ```````--   
  ::-----.....```````````              ```````.-  
 -:-----......```````````               ```````.- 
`+------......```````````               ````````:`
/-------......```````````               `````````:
+-------......```````````               `````````/
+--------......```````````             ``````````/
o--------......````````````          ````````````/
+--------.......``````````````     ``````````````/
+---------.......```````````````````````````````./
./---------......``````````````````````````````.:.
 ::--------........```````````````````````````.-- 
  -/-------.........````````````````````````..:.  
   `/:------.-........````````````````````..-:`   
     -/------...........````````````````...:.     
      `/:----.................`````......-:       
        -/----..........................:-        
         ./----.-....................../.         
          -/----....................../.          
           /-----..-.................-/           
           `+------..................+`           
            +-------................./            
            /---------...-..........-:            
            -:-----------..---..---.:-            
            .:++oooooo++++++++++++++:`            
              +//:://///++++++++++++              
              +//+++++++++++++++++/+              
              o+++++++++++//////::/+              
              o++++/////::://///++++              
              o+/////////+++++++++++              
              ++ooooosssssssssssooo+              
               /dmmmmmmmmmmmmmmmmd/               
                `/////hyyyyh////:`
                
HERE
;
    return 0;
}

1;

