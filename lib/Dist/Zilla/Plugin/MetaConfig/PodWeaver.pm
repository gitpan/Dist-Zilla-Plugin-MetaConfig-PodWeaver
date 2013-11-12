package Dist::Zilla::Plugin::MetaConfig::PodWeaver;

use 5.010001;
use Moose;
with 'Dist::Zilla::Role::ConfigDumper';
with 'Dist::Zilla::Role::Plugin';

our $VERSION = '0.01'; # VERSION

use namespace::autoclean;

sub dump_config {
    my $self = shift;

    my $dump = {};

    #$dump->{_debug_inc} = \%INC;

    my $zilla  = $self->zilla;
    my $dzp_pw;
    for (@{ $zilla->plugins }) {
        say "D0:$_";
        if ($_->isa("Dist::Zilla::Plugin::PodWeaver")) {
            $dzp_pw = $_;
            last;
        }
    }

    say "D:$dzp_pw";
    if ($dzp_pw) {
        my $weaver   = $dzp_pw->weaver;
        $dump->{plugins} = [];
        for my $plugin (@{ $weaver->plugins }) {
            say "D:$plugin";
            push @{ $dump->{plugins} }, {
                class   => $plugin->meta->name,
                name    => $plugin->plugin_name,
                version => $plugin->VERSION,
            };
        }
    }

    return $dump;
}

__PACKAGE__->meta->make_immutable;
1;
# ABSTRACT: Dump more information about Pod::Weaver

__END__

=pod

=encoding UTF-8

=head1 NAME

Dist::Zilla::Plugin::MetaConfig::PodWeaver - Dump more information about Pod::Weaver

=head1 VERSION

version 0.01

=head1 SYNOPSIS

In your F<dist.ini>:

  [MetaConfig::PodWeaver]

=head1 DESCRIPTION

This plugin adds more information about Pod::Weaver configuration (currently:
list of Pod::Weaver plugins and their versions) to be included in top-level
C<X-Dist_Zilla> key of distmeta, under this plugin's config dump.

=head1 FUNCTIONS


None are exported by default, but they are exportable.

=head1 SEE ALSO

L<Dist::Zilla::Plugin::MetaConfig>

=head1 HOMEPAGE

Please visit the project's homepage at L<https://metacpan.org/release/Dist-Zilla-Plugin-MetaConfig-PodWeaver>.

=head1 SOURCE

Source repository is at L<https://github.com/sharyanto/perl-Dist-Zilla-Plugin-MetaConfig-PodWeaver>.

=head1 BUGS

Please report any bugs or feature requests on the bugtracker website L<https://rt.cpan.org/Public/Dist/Display.html?Name=Dist-Zilla-Plugin-MetaConfig-PodWeaver>

When submitting a bug or request, please include a test-file or a
patch to an existing test-file that illustrates the bug or desired
feature.

=head1 AUTHOR

Steven Haryanto <stevenharyanto@gmail.com>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2013 by Steven Haryanto.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
