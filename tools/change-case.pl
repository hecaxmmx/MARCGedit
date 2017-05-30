#!/usr/bin/perl
# [Gedit Tool]
# Save-files=nothing
# Output=replace-selection
# Applicability=all
# Input=document
# Languages=plain,marc
# Name=Change case
# Shortcut=<Primary><Alt>c


 #
 # change-case.pl
 # This file is part of MARCGedit
 #
 # Copyright (C) 2017 - Hector Castro <hector.hecaxmmx@gmail.com>
 #
 # MARCGedit is free software; you can redistribute it and/or
 # modify it under the terms of the GNU Lesser General Public
 # License as published by the Free Software Foundation; either
 # version 3 of the License, or (at your option) any later version.
 #
 # MARCGedit is distributed in the hope that it will be useful,
 # but WITHOUT ANY WARRANTY; without even the implied warranty of
 # MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 # Lesser General Public License for more details.
 #
 # You should have received a copy of the GNU Lesser General Public License
 # along with MARCGedit. If not, see <http://www.gnu.org/licenses/>.
 #

use strict;
use warnings;
use Encode qw/encode decode/;

# Get the selected text env variable
my $text_selection = $ENV{'GEDIT_SELECTED_TEXT'};

# Initialize zenity dialog
my $zenity_dialog = `zenity --list --title="Chage case" --column="Options" "UPPERCASE" "lowercase" "Sentence case" "Capitalize Every Word" 2> /dev/null`;

# Verify if nothing selected
exit if (!defined($text_selection) or $text_selection eq '' or $text_selection eq '~');

# trim new line
$zenity_dialog =~ tr/\n//d;

# Useful encode/decode to convert uppercase accented characters
# https://stackoverflow.com/questions/13261522/uppercase-accented-characters-in-perl

my $enc = 'utf-8';
my $text_str = decode( $enc, $text_selection );
if ( $zenity_dialog eq "UPPERCASE" ) {
    $text_str = uc $text_str;
} elsif ( $zenity_dialog eq "lowercase" ) {
    $text_str = lc $text_str;
} elsif ( $zenity_dialog eq "Sentence case" ) {
    $text_str = lc $text_str;
    $text_str = ucfirst $text_str;
} elsif ( $zenity_dialog eq "Capitalize Every Word" ) {
    $text_str =~ s/([\w']+)/\u\L$1/g;
}
print encode($enc, $text_str);

