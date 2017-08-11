#!/usr/bin/perl
package MARCGedit::Mnemonic::BadMnemonics;

 #
 # MARCGedit::Mnemonic::BadMnemonics.pm
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
use parent 'Exporter';

our @EXPORT_OK = qw(bad_to_right);

=head1 NAME

MARCGedit::Mnemonic::BadMnemonics - Chang incorrect mnemonic produced by MARC::File::MARCMaker to
right mnemonic.

=head1 SYNOPSIS

    use MARCGedit::Mnemonic::BadMnemonics qw(bad_to_right);
    my %hash = bad_to_right(0); # returns hash mnemonics
    values:
    '0' return incorrect mnemonics to right.
    '1' return incorrect mnemonics to hex-uf8 value when mnemonic does not exist.

=cut

my %bad_mnemonics_to_right = (
# Fetch default mnemonics table to UTF-8
    "esc"       =>    "esc",
    "dollar"    =>    "dollar",
    "curren"    =>    "dollar",
    "24"        =>    "dollar",
    "bsol"      =>    "bsol",
    "lcub"      =>    "lcub",
    "rcub"      =>    "rcub",
    "Lstrok"    =>    "iexcl",
    "Ostrok"    =>    "cent",
    "Dstrok"    =>    "pound",
    "AElig"     =>    "yen",
    "OElig"     =>    "brvbar",
    "softsign"  =>    "sect",
    "flat"      =>    "copy",
    "reg"       =>    "ordf",
    "plusmn"    =>    "laquo",
    "mlrhring"  =>    "reg",
    "mllhring"  =>    "deg",
    "lstrok"    =>    "plusmn",
    "ostrok"    =>    "sup2",
    "dstrok"    =>    "sup3",
    "oelig"     =>    "para",
    "hardsign"  =>    "middot",
    "pound"     =>    "sup1",
    "eth"       =>    "ordm",
    "ohorn"     =>    "frac14",
    "uhorn"     =>    "frac12",
    "deg"       =>    "Agrave",
    "scriptl"   =>    "Aacute",
    "phono"     =>    "Acirc",
    "copy"      =>    "Atilde",
    "sharp"     =>    "Auml",
    "iquest"    =>    "Aring",
    "iexcl"     =>    "AElig",
    "hooka"     =>    "agrave",
    "grave"     =>    "aacute",
    "acute"    =>    "acirc",
    "circ"     =>    "atilde",
    "tilde"    =>    "auml",
    "macr"     =>    "aring",
    "breve"    =>    "aelig",
    "dot"      =>    "ccedil",
    "diaer"    =>    "egrave",
    "uml"      =>    "egrave",
    "caron"    =>    "eacute",
    "ring"     =>    "ecirc",
    "llig"     =>    "euml",
    "rlig"     =>    "igrave",
    "rcommaa"  =>    "iacute",
    "dblac"    =>    "icirc",
    "candra"   =>    "iuml",
    "cedil"    =>    "eth",
    "ogon"     =>    "ntilde",
    "dotb"     =>    "ograve",
    "dbldotb"  =>    "oacute",
    "ringb"    =>    "ocirc",
    "dblunder" =>    "otilde",
    "under"    =>    "ouml",
    "commab"   =>    "divide",
    "rcedil"   =>    "ostrok",
    "breveb"   =>    "ugrave",
    "ldbltil"  =>    "uacute",
    "rdbltil"  =>    "ucirc",
    "commaa"   =>    "thorn",
    "THORN"    =>    "curren",
    "7F"       =>    "7F",
    "A0"       =>    "A0",
    "BB"       =>    "raquo",
    "BE"       =>    "frac34",
    "BF"       =>    "iquest",
    "C7"       =>    "Ccedil",
    "C8"       =>    "Egrave",
    "C9"       =>    "Eacute",
    "CA"       =>    "Ecirc",
    "CB"       =>    "Euml",
    "CC"       =>    "Igrave",
    "CD"       =>    "Iacute",
    "CE"       =>    "Icirc",
    "CF"       =>    "Iuml",
    "D0"       =>    "Eth",
    "D1"       =>    "Ntilde",
    "D2"       =>    "Ograve",
    "D3"       =>    "Oacute",
    "D4"       =>    "Ocirc",
    "D5"       =>    "Otilde",
    "D6"       =>    "Ouml",
    "D7"       =>    "times",
    "D8"       =>    "Ostrok",
    "D9"       =>    "Ugrave",
    "DA"       =>    "Uacute",
    "DB"       =>    "Ucirc",
    "DC"       =>    "Uuml",
    "DD"       =>    "Yacute",
    "DE"       =>    "THORN",
    "DF"       =>    "szlig",
    "FC"       =>    "uuml",
    "FD"       =>    "yacute",
    "FF"       =>    "98",
);

my %bad_to_hex = (
    "inodot"    =>    "c2b8",
    "joiner"    =>    "c28d",
    "middot"    =>    "c2a8",
    "nonjoin"   =>    "c28e",
    "thorn"     =>    "c2b4",
    "Ohorn"     =>    "frac14",
    "Uhorn"     =>    "c2ad",
    "aelig"     =>    "c2b5",
    "80"    =>    "c280",
    "81"    =>    "c281",
    "82"    =>    "c282",
    "83"    =>    "c283",
    "84"    =>    "c284",
    "85"    =>    "c285",
    "86"    =>    "c286",
    "87"    =>    "c287",
    "88"    =>    "c288",
    "89"    =>    "c289",
    "8A"    =>    "c28a",
    "8B"    =>    "c28b",
    "8C"    =>    "c28c",
    "8F"    =>    "c28f",
    "90"    =>    "c290",
    "91"    =>    "c291",
    "92"    =>    "c292",
    "93"    =>    "c293",
    "94"    =>    "c294",
    "95"    =>    "c295",
    "96"    =>    "c296",
    "97"    =>    "c297",
    "99"    =>    "c299",
    "9A"    =>    "c29a",
    "9B"    =>    "c29b",
    "9C"    =>    "c29c",
    "9D"    =>    "c29d",
    "9E"    =>    "c29e",
    "9F"    =>    "c29f",
    "AF"    =>    "c2af",
);

#my %combining_mnemonics = (
# If necesary to reproduce combining character
#  "Sacute" => { "S" => "acute" },
#  "Scaron" => { "S" => "caron" },
#);

sub bad_to_right { 
    my $value = shift;

    if ( $value == 0 ) {
       return %bad_mnemonics_to_right;
    } elsif ( $value == 1 ) {
       return %bad_to_hex;
    }
#    } elsif ( $value == 2 ) {
#       return %combining_mnemonics;
#    }
}

1;

__END__

=head1 AUTHOR

Hector Castro <hector.hecaxmmx@gmail.com>

=head1 COPYRIGHT AND LICENSE

This software is Copyright (c) 2017 by Hector Castro.

This is free software, licensed under:

The GNU General Public License, Version 3, June 2007

=cut
