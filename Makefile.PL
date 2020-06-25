#!/usr/bin/perl -w

use 5.010001;
use strict;
use warnings;

use ExtUtils::MakeMaker;
use Devel::CheckLib;

check_lib_or_exit(
    header => 'sys/event.h',
    function => 'return kqueue() == -1 ? 0 : 1;',
);

WriteMakefile(
    VERSION_FROM   => 'KQueue.pm',
    NAME           => 'IO::KQueue',
    PREREQ_PM      => {  },
    CONFIGURE_REQUIRES => { 'Devel::CheckLib' => 0 },
    ABSTRACT_FROM  => 'KQueue.pm',
    AUTHOR         => 'Matt Sergeant <matt@sergeant.org>',
    clean          => {FILES => "tv.log"}
);

eval { require ExtUtils::Constant; 1 };
if (!$@) {
    ExtUtils::Constant::WriteConstants(
        NAME           => 'IO::KQueue',
        NAMES          => [qw(
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
                                NOTE_LOWAT
                                NOTE_DELETE
                                NOTE_WRITE
                                NOTE_EXTEND
                                NOTE_ATTRIB
                                NOTE_LINK
                                NOTE_RENAME
                                NOTE_REVOKE
                                NOTE_EXIT
                                NOTE_FORK
                                NOTE_EXEC
                                NOTE_PCTRLMASK
                                NOTE_PDATAMASK
                                NOTE_TRACK
                                NOTE_TRACKERR
                                NOTE_CHILD
                             )],
    );
}
