#!/usr/bin/perl
package MARCGedit::Mnemonic::BadMnemonicsToChar;

 #
 # MARCGedit::Mnemonic::BadMnemonicsToChar.pm
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

our @EXPORT_OK = qw(bad_to_char);

=head1 NAME

MARCGedit::Mnemonic::BadMnemonicsToChar - Chang incorrect mnemonic produced by MARC::File::MARCMaker to
right utf8 character.

=head1 SYNOPSIS

    use MARCGedit::Mnemonic::BadMnemonicsToChar qw(bad_to_char);
    my %hash = bad_to_char(); # returns hash with hex-utf8

=cut

my %bad_mnemonics_to_char = (
# MARC MARC::File::MARCMaker return bad character mnemonics in utf-8
# Convert to rigth utf-8
# À Á Â Ã Ä à á â ã ä
# c380 c381 c382 c383 c384 c3a0 c3a1 c3a2 c3a3 c3a4
# {deg} => À
    "esc"       =>    "1b",
    "dollar"    =>    "24",
    "curren"    =>    "24",
    "24"        =>    "24",
    "bsol"      =>    "5c",
    "lcub"      =>    "7b",
    "rcub"      =>    "7d",
    "Lstrok"    =>    "c2a1",
    "Ostrok"    =>    "c2a2",
    "Dstrok"    =>    "c2a3",
    "AElig"     =>    "c2a5",
    "softsign"  =>    "c2a7",
    "flat"      =>    "c2a9",
    "reg"       =>    "c2aa",
    "plusmn"    =>    "c2ab",
    "mlrhring"  =>    "c2ae",
    "mllhring"  =>    "c2b0",
    "lstrok"    =>    "c2b1",
    "ostrok"    =>    "c2b2",
    "dstrok"    =>    "c2b3",
    "oelig"     =>    "c2a6",
    "hardsign"  =>    "c2b7",
    "pound"     =>    "c2b9",
    "eth"       =>    "c2ba",
    "ohorn"     =>    "c2bc",
    "uhorn"     =>    "c2bd",
    "deg"       =>    "c380",
    "scriptl"   =>    "c381",
    "phono"     =>    "c382",
    "copy"      =>    "c383",
    "sharp"     =>    "c384",
    "iquest"    =>    "c385",
    "iexcl"     =>    "c386",
    "hooka"     =>    "c3a0",
    "grave"     =>    "c3a1",
    "acute"     =>    "c3a2",
    "circ"      =>    "c3a3",
    "tilde"     =>    "c3a4",
    "macr"      =>    "c3a5",
    "breve"     =>    "c3a6",
    "dot"       =>    "c3a7",
    "diaer"     =>    "c3a8",
    "uml"       =>    "c3a8",
    "caron"     =>    "c3a9",
    "ring"      =>    "c3aa",
    "llig"      =>    "c3ab",
    "rlig"      =>    "c3ac",
    "rcommaa"   =>    "c3ad",
    "dblac"     =>    "c3ae",
    "candra"    =>    "c3af",
    "cedil"     =>    "c3b0",
    "ogon"      =>    "c3b1",
    "dotb"      =>    "c3b2",
    "dbldotb"   =>    "c3b3",
    "ringb"     =>    "c3b4",
    "dblunder"  =>    "c3b5",
    "under"     =>    "c3b6",
    "commab"    =>    "c3b7",
    "rcedil"    =>    "c3b8",
    "breveb"    =>    "c3b9",
    "ldbltil"   =>    "c3ba",
    "rdbltil"   =>    "c3bb",
    "commaa"    =>    "c3be",
    "7F"    =>    "7f",
    "A0"    =>    "c2a0",
    "BB"    =>    "c2bb",
    "BF"    =>    "c2bf",
    "C7"    =>    "c387",
    "C8"    =>    "c388",
    "C9"    =>    "c389",
    "CA"    =>    "c38a",
    "CB"    =>    "c38b",
    "CC"    =>    "c38c",
    "CD"    =>    "c38d",
    "CE"    =>    "c38e",
    "CF"    =>    "c38f",
    "D0"    =>    "c390",
    "D1"    =>    "c391",
    "D2"    =>    "c392",
    "D3"    =>    "c393",
    "D4"    =>    "c394",
    "D5"    =>    "c395",
    "D6"    =>    "c396",
    "D7"    =>    "c397",
    "D8"    =>    "c398",
    "D9"    =>    "c399",
    "DA"    =>    "c39a",
    "DB"    =>    "c39b",
    "DC"    =>    "c39c",
    "DD"    =>    "c39d",
    "DE"    =>    "c39e",
    "DF"    =>    "c39f",
    "FC"    =>    "c3bc",
    "FD"    =>    "c3bd",
    "OElig"    =>    "c2a6",
    "middot"   =>    "c2a8",
    "thorn"    =>    "c2b4",
    "inodot"   =>    "c2b8",
    "BE"       =>    "c2be",
    "FF"       =>    "c3bf",
    "joiner"   =>    "c28d",
    "nonjoin"  =>    "c28e",
    "THORN"    =>    "c2a4",
    "Ohorn"    =>    "c2ac",
    "Uhorn"    =>    "c2ad",
    "aelig"    =>    "c2b5",
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
    "98"    =>    "c298",
    "99"    =>    "c299",
    "9A"    =>    "c29a",
    "9B"    =>    "c29b",
    "9C"    =>    "c29c",
    "9D"    =>    "c29d",
    "9E"    =>    "c29e",
    "9F"    =>    "c29f",
    "AF"    =>    "c2af",
);

sub bad_to_char { %bad_mnemonics_to_char }

1;

__END__

=head1 AUTHOR

Hector Castro <hector.hecaxmmx@gmail.com>

=head1 COPYRIGHT AND LICENSE

This software is Copyright (c) 2017 by Hector Castro.

This is free software, licensed under:

The GNU General Public License, Version 3, June 2007

=cut
