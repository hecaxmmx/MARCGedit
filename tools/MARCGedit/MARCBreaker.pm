#!/usr/bin/perl
package MARCGedit::MARCBreaker;

#
# MARCGedit::MARCBreaker.pm
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
    our $VERSION = '1.00';
    our @ISA     = qw(Exporter);
    our @EXPORT  = qw( file marc mnemonic in breaker );
}

use Carp;
use Encode qw(encode);
use MARC::Batch;
use MARCGedit::MARCMnemonics;
use Class::Accessor 'antlers';

has file     => ( is => 'rw' );
has marc     => ( is => 'rw' );
has mnemonic => ( is => 'rw' );

=head1 NAME

MARCGedit::MARCBreaker - Package that works with MARCBreaker records for MARCGEdit (Convert MARC to Text)

=head1 SYNOPSIS

    use MARCGedit::MARCBreaker;
    my $mrk_record = MARCGedit::MARCBreaker->new( {marc => $record, mnemonic => 0} );
    print $mrk_record->breaker();

=head1 API

=head2 Class Methods

=head3 in

    my $mrk_record = MARCGedit::MARCBreaker->new();
    $mrk_record->in( {file => 'file.mrc'} );
    # or MARC:Record Object instead
    $mrk_record->in( {marc => $record} );
    Enter the file or marc object

=cut

sub in {
    my $self = shift;
    my ($args) = @_;
    my @mrc_record;

    if (@_) {
        $self->marc( $args->{marc} );
        $self->file( $args->{file} );
    }

    if ( exists $self->{file} ) {
        my $batch = MARC::Batch->new( 'USMARC', $self->{file} );
        while ( my $record = $batch->next() ) {
            push @mrc_record, $record;
        }
        return join "", @mrc_record;
    }
    elsif ( exists $self->{marc} ) {
        return $self->{marc};
    }
}

=head3 breaker

    my $mrk_record = MARCGedit::MARCBreaker->new();
    $mrk_record->in( {file => 'file.mrc'} );
    $mrk_record->mnemonic( 0 );
    $mrk_record->breaker();
    Convert the record in ISO2709 or MARC::Object to breaker format in plain text

=cut

sub breaker {
    my $self = shift;
    my ($args) = @_;
    my @mrk_record;

    if (@_) {
        $self->marc( $args->{marc} );
        $self->mnemonic( $args->{mnemonic} );
    }

    if ( $self->{marc} =~ /^MARC::Record/ ) {

        # get all of the fields using the fields() method
        my @fields = $self->{marc}->fields();

        # get the leader
        push @mrk_record, "=LDR  ", $self->{marc}->leader();

        ## print out the tags, the indicators and the field contents
        foreach my $field (@fields) {
            my @asubfields = $field->subfields();

            # printing the control fields
            if ( $field->is_control_field() ) {
                my $control_field_add_backsolidus = $field->as_string();
                $control_field_add_backsolidus =~ s/ /\\/g;
                push @mrk_record, "\n=", $field->tag(), "  ",
                  $control_field_add_backsolidus;
            }

            # printing the rest of the fields
            push @mrk_record, "\n=", $field->tag(), "  "
              unless $field->is_control_field();
            if ( defined $field->indicator(1) ) {
                $field->indicator(1) eq ( " " or "" )
                  ? push @mrk_record, "\\"
                  : push @mrk_record, $field->indicator(1);
            }
            else {
                push @mrk_record, "";
            }
            if ( defined $field->indicator(2) ) {
                $field->indicator(2) eq ( " " or "" )
                  ? push @mrk_record, "\\"
                  : push @mrk_record, $field->indicator(2);
            }
            else {
                push @mrk_record, "";
            }
            foreach my $subfield (@asubfields) {
                my $subfield_encoded = encode( "utf8", @$subfield[1] );
                if ( $self->{mnemonic} == 1 ) {
                    my $mnemonic = utf8_to_mnemonics($subfield_encoded);
                    push @mrk_record, "\$@$subfield[0]$mnemonic";
                }
                else {
                    # convert specials reserved characters $\{} to html number
                    $subfield_encoded =~ s/\$/<&#36;>/g;
                    $subfield_encoded =~ s/\\/<&#92;>/g;
                    $subfield_encoded =~ s/\{/<&#123;>/g;
                    $subfield_encoded =~ s/\}/<&#125;>/g;

                    # convert html number to proper mnemonic
                    $subfield_encoded =~ s/<&#36;>/\{dollar\}/g;
                    $subfield_encoded =~ s/<&#92;>/\{bsol\}/g;
                    $subfield_encoded =~ s/<&#123;>/\{lcub\}/g;
                    $subfield_encoded =~ s/<&#125;>/\{rcub\}/g;
                    push @mrk_record, "\$@$subfield[0]$subfield_encoded";
                }
            }
        }
        push @mrk_record, "\n\n";
    }
    else {
        croak "Object passed is not a MARC::Record object";
    }
    return join "", @mrk_record;
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
