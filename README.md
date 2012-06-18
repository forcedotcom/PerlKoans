Perl::Koans
===========

a framework to learn-by-doing for Perl, with a heavy emphasis on testing

tl;dr: run road_to_illumination.pl, fix test failures specified, repeat until all tests pass

prerequisites
=============

* Perl::Koans - https://github.com/forcedotcom/PerlKoans/blob/freeze/PerlKoans-latest.tar.gz?raw=true (0.50) 
* Perl 5.8.8+
  - Almost all Unix/Linux and OSX machines will already have Perl, confirm with 'perl -v'
  - If you're using Windows, http://www.strawberryperl.com

* ~/PerlKoans/  - don't actually need it to be this path, but this is default

to confirm your environment is working:  
    conor@box $ perl -c road\_to\_illumination.pl  
    road_to_illumination.pl syntax OK  

instructions
============

to get started:

    * run 'perl road_to_illumination.pl', which calls each koan (about_*.pl) in order. you should see something like:

    1.    $ perl road_to_illumination.pl
    2.    not ok 1 - 1 is equal to itself
    3.    #   Failed test '1 is equal to itself'
    4.    #   at about_koans.pl line 15.
    5.    #          got: '1'
    6.    #     expected: '2'
    7.    XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX_____________ 1/266
    8.    Bail out!  he who asks a question is a fool for a minute; he who does not remains a fool forever

    so you won't actually see the line numbers, but they're useful in explaining what's going on:

    line 2 - provides test result 'not ok', test count '1', and test name '1 is equal to itself'
    line 3 - provides a more human friendly representation of line 1
    line 4 - provides the file and line number of the failing test
    line 7 - displays your progression through the Koans
    line 8 - some (hopefully) inspirational sayings

    * now that you know which test is failing, and in which koan that test lives, go fix the test -- repeat until all tests pass:

Perl::Koans uses the string '__' to indicate where you should fill in your code, typically a value or variable.

  * for example, if you see:
        is (1, \__, "1 is equal to itself test");
        
  * to pass the test, you would fill in '1':
        is (1, 1, "1 is equal to itself test");

in other cases, you may see a failing test without the '__', but the intent is the same: fix the test.

  * for example, if you see:
        is (1, 2, "1 is equal to itself test");
        
  * pass the test by replacing the 'expected' value to '1':
        is (1, 1, "1 is equal to itself test");

Perl::Koans provides some anchors for where you should be looking to fix tests:

    ################
    # your code goes below this line


    # your code goes above this line
    ################

you can walk the road (i.e. fix tests) in whatever editor you choose, here are a few suggestions:

    * Windows - Notepad++, Eclipse
    * Unix    - GEdit, Eclipse, vim
    * OS X    - Text Wrangler, Eclipse, vim

Komodo Edit is another option, available for all platforms

Test::More
==========

tests aren't just used in 'if' statements!

Test::More is the de facto standard framework for testing in Perl.

the functions used in Perl::Koans:

    * is(<got>, <expected>, <testname>) - successful if <got> is equal to <expected> 
    * ok(<value>, <testname>) - successful if <value> is true
    * like(<got>, <regular_expression>, <testname>) - successful if <got> matches <regular_expression>


credits
=======

rubykoans.com

