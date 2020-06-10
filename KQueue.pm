# $Id: KQueue.pm,v 1.1.1.1 2005/02/17 16:49:08 matt Exp $

package IO::KQueue;

use strict;
use vars qw($VERSION @ISA @EXPORT $AUTOLOAD $MAX_EVENTS);

use DynaLoader ();
use Exporter ();

use Errno;

$VERSION = '0.25';

$MAX_EVENTS = 1000;

@ISA = qw(Exporter DynaLoader);
@EXPORT = qw(
    EV_ADD
    EV_DELETE
    EV_ENABLE
    EV_DISABLE
    EV_ONESHOT
    EV_CLEAR
    EV_EOF
    EV_ERROR
    EVFILT_READ
    EVFILT_WRITE
    EVFILT_VNODE
    EVFILT_PROC
    EVFILT_SIGNAL
    EVFILT_TIMER
    EVFILT_FS
);

bootstrap IO::KQueue $VERSION;

sub DESTROY {
}

sub AUTOLOAD {
    my $sub = $AUTOLOAD;
    (my $constname = $sub) =~ s/.*:://;
    my ($err, $val) = constant($constname);
    if (defined($err)) {
        die $err;
    }
    eval "sub $sub () { $val }";
    goto &$sub;
}

1;

__END__

=head1 NAME

IO::KQueue - perl interface to the BSD kqueue system call

=head1 SYNOPSIS

    my $kq = IO::KQueue->new();
    $kq->EV_SET($fd, EVFILT_READ, EV_ADD, 0, 5);
    
    my %results = $kq->kevent($timeout);

=head1 DESCRIPTION

This module provides a fairly low level interface to the BSD kqueue() system
call, allowing you to monitor for changes on sockets, files, processes and
signals.

Usage is very similar to the kqueue system calls, so you will need to have
read and understood the kqueue man page. This document may seem fairly light on
details but that is merely because the details are in the man page, and so I
don't wish to replicate them here.

=head1 API

=head2 C<< IO::KQueue->new() >>

Construct a new KQueue object (maps to the C<kqueue()> system call).

=head2 C<< $kq->EV_SET($ident, $filt, $flags, $fflags, $data, $udata) >>

e.g.:

  $kq->EV_SET(fileno($server), EVFILT_READ, EV_ADD, 0, 5);

Equivalent to the EV_SET macro followed immediately by a call to kevent() to
set the event up.

Note that to watch for both I<read> and I<write> events you need to call this
method twice - once with EVFILT_READ and once with EVFILT_WRITE - unlike
C<epoll()> and C<poll()> these "filters" are not a bitmask.

Returns nothing. Throws an exception on failure.

The C<$fflags>, C<$data> and C<$udata> params are optional.

=head2 C<< $kq->kevent($timeout) >>

Poll for events on the kqueue. Timeout is in milliseconds. If timeout is zero
or ommitted then we poll forever until there are events to read.

Returns a list of C<< (ident, filt) >> pairs which you can either assign
directly to a hash, or iterate through. See the included F<chat.pl> program
for an example usage.

NOTE: The API here may be extended to return additional flags. Email the author
for ideas about this.

=head1 CONSTANTS

For a list of exported constants see the source of F<Makefile.PL>, or the
kqueue man page.

=head1 LICENSE

This is free software. You may use it and distribute it under the same terms
as Perl itself - i.e. either the Perl Artistic License, or the GPL version 2.0.

=head1 AUTHOR

Matt Sergeant, <matt@sergeant.org>

Copyright 2005 MessageLabs Ltd.

=head1 SEE ALSO

L<IO::Poll>

=cut