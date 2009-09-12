# $Id: $

package tiny;

our $VERSION = 1;

# Registry is module name followed by module replacement
# and some flags (the only used flag now is used to define
# if a namespace wrapper - think @ISA - should be installed).
#
# This is necessary if the original and the tiny module don't
# have the same namespace.

our %registry = (
    'YAML.pm'            => undef,
    'Config/IniFiles.pm' => 'Config/Tiny.pm', 
    'XML/Parser.pm'      => 'XML/Tiny.pm',
);

BEGIN {
    sub prefer_tinies ($;$) {
        my @args = @_;
        my $tiny;
        my $already_loaded;

        for my $mod (@args) {
            $tiny = rewrite_module($mod);
            $already_loaded = exists $INC{$tiny};
            CORE::require($tiny);
            #print "Req=$tiny=", CORE::require($tiny), "\n";
            if ($mod eq $tiny)  { return }
            if ($already_loaded){ return }
            # Install namespace wrapper
            for ($mod, $tiny) {
                s{/}{::}g;
                s{\.pm$}{};
            }
            #warn "Pushing ${mod}::ISA with $tiny\n";
            push @{"${mod}::ISA"}, $tiny;
        }
        return;
    }
}

# Enable alternate require that prefers tinies
sub import {
    *CORE::GLOBAL::require = \&prefer_tinies;
    return;
}

# Back to regular require
sub unimport {
    *CORE::GLOBAL::require = \&CORE::require;
    return;
}

# Hardcoded list of tinies to be enabled
sub rewrite_module {
    my $mod = $_[0];
    if (exists $registry{$mod}) {
        if (defined $registry{$mod}) {
            $mod = $registry{$mod};
        }
        else {
            substr($mod, -3, 0, '/Tiny');
        }
    }
    #warn 'Mod ', $_[0], ' replaced with ', $mod, "\n";
    return $mod;
}

1;

__END__

=head1 NAME

tiny - The great new tiny!

=head1 VERSION

Version 0.01

=head1 SYNOPSIS

Quick summary of what the module does.

Perhaps a little code snippet.

    use tiny;

    my $foo = tiny->new();
    ...

=head1 EXPORT

A list of functions that can be exported.  You can delete this section
if you don't export anything, such as for a purely object-oriented module.

=head1 FUNCTIONS

=head2 function1

=head2 function2

=head1 AUTHOR

Cosimo Streppone, C<< <cosimo at cpan.org> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-tiny at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=tiny>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc tiny

You can also look for information at:

=over 4

=item * RT: CPAN's request tracker

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=tiny>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/tiny>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/tiny>

=item * Search CPAN

L<http://search.cpan.org/dist/tiny>

=back


=head1 ACKNOWLEDGEMENTS


=head1 COPYRIGHT & LICENSE

Copyright 2008 Cosimo Streppone, all rights reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.


