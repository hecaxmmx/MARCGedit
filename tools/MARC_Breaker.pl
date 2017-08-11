#!/usr/bin/perl
# [Gedit Tool]
# Name=MARC Breaker
# Output=append-document
# Shortcut=<Primary><Alt>b
# Input=nothing
# Languages=marc
# Applicability=all
# Save-files=nothing

#
# MARC_Breaker.pl
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

## Processing a batch of MARC records in ISO2709 and converting to MARCBreaker format

use strict;
use warnings;
use MARC::Batch;

# Change @INC from inside the script
# <https://perlmaven.com/how-to-create-a-perl-module-for-code-reuse>
use File::Basename qw(dirname);
use Cwd qw(abs_path);
use lib dirname( dirname abs_path $0) . '/tools';

use MARCGedit::MARCBreaker;

# Global dialog error
my @zenity_error_dialog = ( 'zenity', '--error', );

#open mrc/ISO2709 format
my $zenity_dialog_open =
  `zenity --file-selection --title="Select a File" 2> /dev/null`;

#trim new line for open dialog
$zenity_dialog_open =~ tr/\n//d;

# checking if file is selected
if ( $? == 256 ) {
    print STDERR
      "No file selected. Please select a valid file format (mrk, txt, and dat)\n";
    push @zenity_error_dialog, '--text="No file selected.\n',
      'Please select a valid file format (mrk, txt, and dat)"';
    system("@zenity_error_dialog 2> /dev/null");
    exit;
}
elsif ( not $zenity_dialog_open =~ /(\.mrc$|\.MRC$|\.dat$|\.DAT$)/ ) {

    # checking for valid file format
    print STDERR
      "Please select a valid file format. Formats accepted are mrc, and dat.\n";
    push @zenity_error_dialog, '--text="Please select a valid file format.\n',
      'Formats accepted are mrk, and dat."';
    system("@zenity_error_dialog 2> /dev/null");
    exit;
}

# Declaring dialog for Latin and Non-Latin Script
my $zenity_dialog_output_format = `zenity --list \\
    --title="Choose the MARC Breaker output" \\
    --column="Character Sets" --column="Mnemonic strings" \\
    "Basic Latin Script" Yes "Latin and Non-Latin Scripts" "Reserved characters only" \\
    2> /dev/null`;

# trim new line for output format dialog
$zenity_dialog_output_format =~ tr/\n//d;

my $rec_count = 0;

#initialize $batch_mrc as new MARC::Batch object
my $batch_mrc = MARC::Batch->new( 'USMARC', $zenity_dialog_open );

if ( $zenity_dialog_output_format eq "Basic Latin Script" )
{    #print "Latin Scripts";
    while ( my $record = $batch_mrc->next() ) {
        $rec_count++;
        my $mrk_record =
          MARCGedit::MARCBreaker->new( { marc => $record, mnemonic => 1 } );
        print $mrk_record->breaker();
    }    # while
}
elsif ( $zenity_dialog_output_format eq "Latin and Non-Latin Scripts" )
{        #print "Non-Latin Scripts";
    while ( my $record = $batch_mrc->next() ) {
        $rec_count++;
        my $mrk_record =
          MARCGedit::MARCBreaker->new( { marc => $record, mnemonic => 0 } );
        print $mrk_record->breaker();
    }    # while
}
else {
    exit;
}    #if
print STDERR "$rec_count record(s) processed\n";

1;
