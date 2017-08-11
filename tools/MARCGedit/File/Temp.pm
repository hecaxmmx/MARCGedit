#!/usr/bin/perl
package MARCGedit::File::Temp;

 #
 # MARCGedit::File::Temp.pm
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
BEGIN {
    require Exporter;
    our $VERSION     = '1.00';
    our @ISA         = qw(Exporter);
    our @EXPORT      = qw( write remove $filename );
}

use Class::Accessor 'antlers';

    has dir          => ( is => 'ro' );
    has suffix       => ( is => 'ro' );

our $filename; # Variable created to store file name

=head1 NAME

MARCGedit::File::Temp - Create a temporary file without using external library (e.g. File::Temp)

=head1 SYNOPSIS

    use MARCGedit::File::Temp;
    my $tmp_file = MARCGedit::File::Temp->new( {suffix => '.dat', dir => '/tmp/'} );
    $tmp_file->write( $text );
    $tmp_mrk->remove();

    # Acceding to name file created randomly
    $MARCGedit::File::Temp::filename

=head1 API

=head2 Class Methods

=head3 filename

    my $filename = $self->filename
    Return a random name for the temporary file

=cut

sub filename {
    my $self = shift;
    my $tmp_file;
    my @letters = ('A' .. 'Z', 'a' .. 'z', '0' .. '9', '-', '_');
    $tmp_file .= $letters[rand @letters] for 1 .. 8;
    $tmp_file .= $self->suffix if defined $self->suffix;
    return $tmp_file;
}

=head3 openfile

    my $fh = $self->openfile;
    Open a temporary file and return the filehandle

=cut

sub openfile {
    my $self = shift;
    if( defined $self->dir ) {
        $filename = $self->dir . $self->filename;
    } else {
        $filename = $self->filename;
    }
    open( my $tmp_mrk, ">", $filename ) or die "Can't open file '$filename' $!";
    return $tmp_mrk;
}

=head3 write

    $tmp_file->write( $text );
    Write in temporary file and close the filehandle

=cut

sub write {
    my $self = shift;
    my ( $data ) = @_;
    my $fh = $self->openfile;
    print $fh $data;
    close( $fh );
}

=head3 remove

    $tmp_file->remove();
    Unlink the temporary file

=cut

sub remove {
    my $self = shift;
    unlink $filename;
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
