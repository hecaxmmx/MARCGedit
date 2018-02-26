#!/usr/bin/perl
package MARCGedit::Mnemonic::Characters;

 #
 # MARCGedit::Mnemonic::Characters.pm
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

our @EXPORT_OK = qw(character_to_mnemonics);

=head1 NAME

MARCGedit::Mnemonic::Characters - Has all MARCMaker Mnemonics and right utf8 in hexadecimal in a hash

=head1 SYNOPSIS

    use MARCGedit::Mnemonic::Characters qw(character_to_mnemonics);
    my %hash = character_to_mnemonics(); # returns hash mnemonics

=cut

my %characters = (
"c2a1"    =>    "iexcl",
"c2a2"    =>    "cent",
"c2a3"    =>    "pound",
"c2a4"    =>    "curren",
"c2a5"    =>    "yen",
"c2a6"    =>    "brvbar",
"c2a7"    =>    "sect",
"c2a9"    =>    "copy",
"c2aa"    =>    "ordf",
"c2ab"    =>    "laquo",
"c2ae"    =>    "reg",
"c2b0"    =>    "deg",
"c2b1"    =>    "plusmn",
"c2b2"    =>    "sup2",
"c2b3"    =>    "sup3",
"c2b6"    =>    "para",
"c2b7"    =>    "middot",
"c2b9"    =>    "sup1",
"c2ba"    =>    "ordm",
"c2bb"    =>    "raquo",
"c2bc"    =>    "frac14",
"c2bd"    =>    "frac12",
"c2be"    =>    "frac34",
"c2bf"    =>    "iquest",
"c380"    =>    "Agrave",
"c381"    =>    "aacute",
"c382"    =>    "Acirc",
"c383"    =>    "Atilde",
"c384"    =>    "Auml",
"c385"    =>    "Aring",
"c386"    =>    "AElig",
"c387"    =>    "Ccedil",
"c388"    =>    "Egrave",
"c389"    =>    "Eacute",
"c38a"    =>    "Ecirc",
"c38b"    =>    "Euml",
"c38c"    =>    "Igrave",
"c38d"    =>    "Iacute",
"c38e"    =>    "Icirc",
"c38f"    =>    "Iuml",
"c390"    =>    "Eth",
"c391"    =>    "Ntilde",
"c392"    =>    "Ograve",
"c393"    =>    "Oacute",
"c394"    =>    "Ocirc",
"c395"    =>    "Otilde",
"c396"    =>    "Ouml",
"c397"    =>    "times",
"c398"    =>    "Ostrok",
"c399"    =>    "Ugrave",
"c39a"    =>    "Uacute",
"c39b"    =>    "Ucirc",
"c39c"    =>    "Uuml",
"c39d"    =>    "Yacute",
"c39e"    =>    "THORN",
"c39f"    =>    "szlig",
"c3a0"    =>    "agrave",
"c3a1"    =>    "aacute",
"c3a2"    =>    "acirc",
"c3a3"    =>    "atilde",
"c3a4"    =>    "auml",
"c3a5"    =>    "aring",
"c3a6"    =>    "aelig",
"c3a7"    =>    "ccedil",
"c3a8"    =>    "egrave",
"c3a9"    =>    "eacute",
"c3aa"    =>    "ecirc",
"c3ab"    =>    "euml",
"c3ac"    =>    "igrave",
"c3ad"    =>    "iacute",
"c3ae"    =>    "icirc",
"c3af"    =>    "iuml",
"c3b0"    =>    "eth",
"c3b1"    =>    "ntilde",
"c3b2"    =>    "ograve",
"c3b3"    =>    "oacute",
"c3b4"    =>    "ocirc",
"c3b5"    =>    "otilde",
"c3b6"    =>    "ouml",
"c3b7"    =>    "divide",
"c3b8"    =>    "ostrok",
"c3b9"    =>    "ugrave",
"c3ba"    =>    "uacute",
"c3bb"    =>    "ucirc",
"c3bc"    =>    "uuml",
"c3bd"    =>    "yacute",
"c3be"    =>    "thorn",
"c482"    =>    "Abreve",
"c483"    =>    "abreve",
"c484"    =>    "Aogon",
"c485"    =>    "aogon",
"c486"    =>    "Cacute",
"c487"    =>    "cacute",
"c48c"    =>    "Ccaron",
"c48d"    =>    "ccaron",
"c48e"    =>    "Dcaron",
"c48f"    =>    "dcaron",
"c490"    =>    "Dstrok",
"c491"    =>    "dstrok",
"c498"    =>    "Eogon",
"c499"    =>    "eogon",
"c49a"    =>    "Ecaron",
"c49b"    =>    "ecaron",
"c4b0"    =>    "Idot",
"c4b1"    =>    "inodot",
"c4b2"    =>    "IJlig",
"c4b3"    =>    "ijlig",
"c4b9"    =>    "Lacute",
"c4ba"    =>    "lacute",
"c581"    =>    "Lstrok",
"c582"    =>    "lstrok",
"c583"    =>    "Nacute",
"c584"    =>    "nacute",
"c587"    =>    "Ncaron",
"c588"    =>    "ncaron",
"c590"    =>    "Odblac",
"c591"    =>    "odblac",
"c592"    =>    "OElig",
"c593"    =>    "oelig",
"c594"    =>    "Racute",
"c595"    =>    "racute",
"c598"    =>    "Rcaron",
"c599"    =>    "rcaron",
"c59a"    =>    "Sacute",
"c59b"    =>    "sacute",
"c5a4"    =>    "Tcaron",
"c5a5"    =>    "tcaron",
"c5ae"    =>    "Uring",
"c5af"    =>    "uring",
"c5b0"    =>    "Udblac",
"c5b1"    =>    "udblac",
"c5b9"    =>    "Zacute",
"c5ba"    =>    "zacute",
"c5bb"    =>    "Zdot",
"c5bc"    =>    "zdot",
"c6a0"    =>    "Ohorn",
"c6a1"    =>    "ohorn",
"c6af"    =>    "Uhorn",
"c6b0"    =>    "uhorn",
"c78f"    =>    "Icaron",
"c790"    =>    "icaron",
"c898"    =>    "Scommab",
"c899"    =>    "scommab",
"c89a"    =>    "Tcommab",
"c89b"    =>    "tcommab",
"cab9"    =>    "mlprime",
"caba"    =>    "mlPrime",
"cabe"    =>    "alif",
"cabf"    =>    "ayn",
"cc80"    =>    "grave",
"cc81"    =>    "acute",
"cc82"    =>    "circ",
"cc83"    =>    "tilde",
"cc84"    =>    "macr",
"cc86"    =>    "breve",
"cc87"    =>    "dot",
"cc88"    =>    "diaer",
"cc88"    =>    "uml",
"cc89"    =>    "hooka",
"cc8a"    =>    "ring",
"cc8b"    =>    "dblac",
"cc8c"    =>    "caron",
"cc90"    =>    "candra",
"cc93"    =>    "commaa",
"cc95"    =>    "rcommaa",
"cca1"    =>    "hookl",
"cca2"    =>    "hookr",
"cca3"    =>    "dotb",
"cca4"    =>    "dbldotb",
"cca5"    =>    "ringb",
"cca6"    =>    "commab",
"cca7"    =>    "cedil",
"cca8"    =>    "ogon",
"cca9"    =>    "vlineb",
"ccad"    =>    "circb",
"ccae"    =>    "breveb",
"ccb2"    =>    "under",
"ccb3"    =>    "dblunder",
"cda3"    =>    "asuper",
"ceb1"    =>    "agr",
"ceb2"    =>    "bgr",
"ceb3"    =>    "ggr",
"d081"    =>    "IOcy",
"d082"    =>    "DJEcy",
"d083"    =>    "GJEcy",
"d085"    =>    "DZEcy",
"d087"    =>    "JIcy",
"d088"    =>    "JEcy",
"d089"    =>    "LJEcy",
"d08a"    =>    "NJEcy",
"d08b"    =>    "TSHEcy",
"d08c"    =>    "KJEcy",
"d08f"    =>    "DZHEcy",
"d090"    =>    "Acy",
"d091"    =>    "Bcy",
"d092"    =>    "Vcy",
"d093"    =>    "Gcy",
"d094"    =>    "Dcy",
"d095"    =>    "IEcy",
"d096"    =>    "ZHcy",
"d097"    =>    "Zcy",
"d098"    =>    "Icy",
"d099"    =>    "Jcy",
"d09a"    =>    "Kcy",
"d09b"    =>    "Lcy",
"d09c"    =>    "Mcy",
"d09d"    =>    "Ncy",
"d09e"    =>    "Ocy",
"d09f"    =>    "Pcy",
"d0a0"    =>    "Rcy",
"d0a1"    =>    "Scy",
"d0a2"    =>    "Tcy",
"d0a3"    =>    "Ucy",
"d0a4"    =>    "Fcy",
"d0a5"    =>    "KHcy",
"d0a6"    =>    "TScy",
"d0a7"    =>    "CHcy",
"d0a8"    =>    "SHcy",
"d0a9"    =>    "SHCHcy",
"d0aa"    =>    "HARDcy",
"d0ab"    =>    "Ycy",
"d0ac"    =>    "SOFTcy",
"d0ad"    =>    "Ecy",
"d0ae"    =>    "YUcy",
"d0af"    =>    "YAcy",
"d0b0"    =>    "acy",
"d0b1"    =>    "bcy",
"d0b2"    =>    "vcy",
"d0b3"    =>    "gcy",
"d0b4"    =>    "dcy",
"d0b5"    =>    "iecy",
"d0b5"    =>    "yecy",
"d0b6"    =>    "zhcy",
"d0b7"    =>    "zcy",
"d0b8"    =>    "icy",
"d0b9"    =>    "jcy",
"d0ba"    =>    "kcy",
"d0bb"    =>    "lcy",
"d0bc"    =>    "mcy",
"d0bd"    =>    "ncy",
"d0be"    =>    "ocy",
"d0bf"    =>    "pcy",
"d180"    =>    "rcy",
"d181"    =>    "scy",
"d182"    =>    "tcy",
"d183"    =>    "ucy",
"d184"    =>    "fcy",
"d185"    =>    "khcy",
"d186"    =>    "tscy",
"d187"    =>    "chcy",
"d188"    =>    "shcy",
"d189"    =>    "shchcy",
"d18a"    =>    "hardcy",
"d18b"    =>    "ycy",
"d18c"    =>    "softcy",
"d18d"    =>    "ecy",
"d18e"    =>    "yucy",
"d18f"    =>    "yacy",
"d191"    =>    "iocy",
"d192"    =>    "djecy",
"d193"    =>    "gjecy",
"d195"    =>    "dzecy",
"d197"    =>    "jicy",
"d197"    =>    "yiumlcy",
"d198"    =>    "jecy",
"d199"    =>    "ljecy",
"d19a"    =>    "njecy",
"d19b"    =>    "tshecy",
"d19c"    =>    "kjecy",
"d19f"    =>    "dzhecy",
"d290"    =>    "GHcy",
"d291"    =>    "ghcy",
"d2ba"    =>    "Hcy",
"d2bb"    =>    "hcy",
"d3a4"    =>    "Iumlcy",
"d3a5"    =>    "iumlcy",
#"e2808c"    =>    "nonjoin",
"e28094"    =>    "mdash",
"e28098"    =>    "lsquo",
"e28099"    =>    "rsquo",
"e2809c"    =>    "ldquo",
"e2809d"    =>    "rdquo",
"e280a0"    =>    "dagger",
"e280a1"    =>    "Dagger",
"e280a2"    =>    "bull",
"e280a6"    =>    "hellip",
"e28292"    =>    "osuper",
"e28496"    =>    "No",
"e28497"    =>    "phono",
"e284a2"    =>    "trade",
"e299ad"    =>    "flat",
"e299af"    =>    "sharp",
"ea9a9c"    =>    "hardsign",
"ea9a9d"    =>    "softsign",
"efb8a0"    =>    "llig",
"efb8a1"    =>    "rlig",
"efb8a2"    =>    "ldbltil",
"efb8a3"    =>    "rdbltil"
);

sub character_to_mnemonics { return %characters; }

1;

__END__

=head1 AUTHOR

Hector Castro <hector.hecaxmmx@gmail.com>

=head1 COPYRIGHT AND LICENSE

This software is Copyright (c) 2017 by Hector Castro.

This is free software, licensed under:

The GNU General Public License, Version 3, June 2007

=cut