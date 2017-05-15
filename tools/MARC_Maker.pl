#!/usr/bin/perl
# [Gedit Tool]
# Name=MARC Maker
# Shortcut=<Primary><Alt>m
# Languages=marc
# Applicability=all
# Output=output-panel
# Input=nothing
# Save-files=nothing

 #
 # MARC_Maker.pl
 # This file is part of MARCGedit
 #
 # Copyright (C) 2015 - Hector Castro <hector.hecaxmmx@gmail.com>
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

## Processing a batch of MARC records in MARCMaker format and converting to ISO2709

use strict;
use warnings;
use MARC::Batch;
use MARC::File::MARCMaker;

# Open up zenity dialog without UI::Dialog::Backend::Zenity
# Using backticks instead
# Althoug can use open(ZEN,"zenity --entry --title=' ... |") || die "Failed: $!\n"; exec(), and system().

# Global dialog error
my @args_err_dialog = (
    'zenity',
    '--error',
    );

my $current_path = $ENV{'GEDIT_CURRENT_DOCUMENT_DIR'};

# Launch error dialog if document is unsaved.
# This dialog is avoided if Applicability: is set to untitled documents. By default set it to all documents.
if (not defined $current_path){
    push @args_err_dialog, '--text="The current document is new or unsaved. Please, save the document first.\nLikewise, this tool works with saved document not with the buffer of file.\nPlease save the document first to prevent data loss."';
    system("@args_err_dialog 2> /dev/null");
    exit;
}

my $zenity_dialog = `zenity --file-selection --save --title="Save File" 2> /dev/null`;

if ($? == 0) {
    # Deleting new line character
    $zenity_dialog =~ tr/\n//d;
    # Launching error dialog if whitespaces found
    if (($zenity_dialog =~ /[ \f\t\v]+$/) or (not defined $zenity_dialog)) {
        push @args_err_dialog, '--text="This error is caused because your file name contains only spaces, or, spaces at the end of the line"';
        system("@args_err_dialog 2> /dev/null");
        exit;
    }
    # MARC file already exist
    if ( -e $zenity_dialog ) {
        system('zenity --question --text="The file already exist. Are you sure you wish to proceed?" 2> /dev/null');
        my $status = sprintf("%d", $? >> 8);
        exit if $status == 1;
    }
    # Add the extension .mrc or avoid
    $zenity_dialog .= '.mrc' unless ($zenity_dialog =~ /(\.mrc$|\.MRC$)/);

    # Declaring mrk and mrc files
    my $mrk_in = $ENV{'GEDIT_CURRENT_DOCUMENT_NAME'};
    my $mrc_out = $zenity_dialog;

    # If $mrc_out is defined then process the batch to MARCMaker
    if (defined $mrc_out){
        print "Processing: '$mrk_in'\n" .
              "Converting to MARC binary file: '$mrc_out'\n";

        # initialize $batch_mrk as new MARC::Batch object
        my $batch_mrk = MARC::Batch->new( 'MARCMaker', $mrk_in );

        # open mrc (ISO2709) format output file
        open my $OUTMRC, ">$mrc_out" or die "Can not open the file $mrc_out, $!";

        # Iterating through a batch file
        my $rec_count = 0;
        while (my $record = $batch_mrk->next()){
            $rec_count++;
            my $marc = $record->as_usmarc();
            print $OUTMRC $marc;
        }

        print "'$rec_count' record(s) processed\n";

        close $OUTMRC;

        # Info dialog, reporting the end of the process
        my @msg = (
            'Processed file: \n\t',
            join ("/", $current_path, $mrk_in),
            '\n',
            'Converted to MARC binary file: \n\t',
            $mrc_out,
            '\n',
            $rec_count,
            'record(s) processed \n',
        );
        system("zenity --info --text='@msg' 2> /dev/null");
        exit;
    } #if $mrc_out
} #if $?
1;
