package CallBackery::GuiPlugin::AbstractCardlist;
use Carp qw(carp croak);
use CallBackery::Translate qw(trm);
use CallBackery::Exception qw(mkerror);
use Text::CSV;
use Excel::Writer::XLSX;
use Mojo::JSON qw(true false);
use POSIX qw(strftime);

=head1 NAME

CallBackery::GuiPlugin::AbstractCardlist - Base Class for a cardlist plugin

=head1 SYNOPSIS

 use Mojo::Base 'CallBackery::GuiPlugin::AbstractCardlist';

=head1 DESCRIPTION

The base class for cardlist forms.

=cut

use Mojo::Base 'CallBackery::GuiPlugin::AbstractForm';

=head1 ATTRIBUTES

The attributes of the L<CallBackery::GuiPlugin::AbstractForm> class and these:

=head2 checkAccess

Check permissions.

=cut

has checkAccess => sub {
    shift->user->userId ? 1 : 0;
};

=head2 cardCfg

Configuration of the card list cards

return [
    layout => {
        class => 'qx.ui.layout.Grid',
        setFunctions => {
            setColumnFlex => [
                [ 0, 1 ],
                [ 5, 1 ],
            ],
            setColumnWidth => [
                [ 5, 200 ],
            ],
            setColumnAlign => [
                [ 5, 'right', 'bottom' ],
            ],
            setSpacingX => [ [20], ],
            setSpacingY => [ [3],  ],
        },
    },
    form => [
        {
            label => {
                addSet => { row => 0, column => 0, },
                set => {
                    value => trm('Type'),
                },
            },
            field => {
                addSet => { row => 1, column => 0, },
                class  => 'qx.ui.form.TextField',
                key    => 'oatkg_label',
                set    => { width => 100, readOnly => true },
            },
        },
];

=cut

has cardCfg => sub {
    die mkerror(3456, "cardCfg must be defined in child class");
};

=head2 screenCfg

Custom default screen configuration.

=cut

has screenCfg => sub {
    my $self = shift;
    my $screen = $self->SUPER::screenCfg;
    $screen->{type}    = 'cardlist';
    $screen->{cardCfg} = $self->cardCfg;
    return $screen;
};

=head2 actionCfg

Default action configuration.

=cut

has actionCfg => sub {
    my $self = shift;
    return {
        action   => 'refresh',
        interval => $self->refreshInterval,
    };
};

=head2 refreshInterval

Default screen refresh interval in milliseconds.

=cut

has refreshInterval => sub {
    return 1000;
};

=head1 METHODS

All the methods of L<CallBackery::GuiPlugin::AbstractForm> plus:

=cut

=head2 makeExportAction(type => 'XLSX', filename => 'export-"now"', label => 'Export')

Create export button.
The default type is XLSX, also available is CSV.

=cut

sub makeExportAction {
    die mkerror(999, "makeExportAction() not yet implemented");
}

1;
__END__

=head1 LICENSE

This program is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation; either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program; if not, write to the Free Software
Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.

=head1 COPYRIGHT

Copyright (c) 2013-2020 by OETIKER+PARTNER AG. All rights reserved.

=head1 AUTHOR

S<Fritz Zaucker E<lt>fritz.zaucker@oetiker.chE<gt>>

=head1 HISTORY

 2020-09-01 fz 1.0 first version

=cut

# Emacs Configuration
#
# Local Variables:
# mode: cperl
# eval: (cperl-set-style "PerlStyle")
# mode: flyspell
# mode: flyspell-prog
# End:
#
# vi: sw=4 et