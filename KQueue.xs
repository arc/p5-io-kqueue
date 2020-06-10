/* $Id: KQueue.xs,v 1.3 2005/03/02 15:21:07 matt Exp $ */

#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"

#include <errno.h>
#include <string.h>

#include <sys/types.h>
#include <sys/event.h>
#include <sys/time.h>

#include "const-c.inc"

typedef int kqueue_t;

MODULE = IO::KQueue  PACKAGE = IO::KQueue

PROTOTYPES: DISABLE

INCLUDE: const-xs.inc

kqueue_t
new(CLASS)
    const char * CLASS
    CODE:
        RETVAL = kqueue();
        if (RETVAL == -1) {
            croak("kqueue() failed: %s", strerror(errno));
        }
    OUTPUT:
        RETVAL

void
EV_SET(kq, ident, filter, flags, fflags = 0, data = 0, udata = NULL)
    kqueue_t    kq
    uintptr_t   ident
    short       filter
    u_short     flags
    u_short     fflags
    intptr_t    data
    SV        * udata
  PREINIT:
    struct kevent ke;
    int i;
  PPCODE:
    memset(&ke, 0, sizeof(struct kevent));
    if (udata)
        SvREFCNT_inc(udata);
    EV_SET(&ke, ident, filter, flags, fflags, data, udata);
    i = kevent(kq, &ke, 1, NULL, 0, NULL);
    if (i == -1) {
        croak("set kevent failed: %s", strerror(errno));
    }

void
kevent(kq, timeout=&PL_sv_undef)
    kqueue_t    kq
    SV *        timeout
  PREINIT:
    int num_events, i;
    struct timespec t;
    struct kevent *ke = NULL;
    struct timespec *tbuf = (struct timespec *)0;
    I32 max_events = SvIV(get_sv("IO::KQueue::MAX_EVENTS", FALSE));
  PPCODE:
    dXSTARG;
    Newz(0, ke, max_events, struct kevent);
    if (ke == NULL) {
        croak("malloc failed");
    }
    
    if (timeout != &PL_sv_undef) {
        I32 time = SvIV(timeout);
        t.tv_sec = time / 1000;
        t.tv_nsec = (time % 1000) * 1000000;
        tbuf = &t;
    }
    
    num_events = kevent(kq, NULL, 0, ke, max_events, tbuf);
    
    if (num_events == -1) {
        croak("kevent error: %s", strerror(errno));
    }
    
    EXTEND(SP, num_events);
    for (i = 0; i < num_events; i++) {
        AV * array = newAV();
        av_push(array, newSViv(ke[i].ident));
        av_push(array, newSViv(ke[i].filter));
        av_push(array, newSViv(ke[i].flags));
        av_push(array, newSViv(ke[i].fflags));
        av_push(array, newSViv(ke[i].data));
        av_push(array, SvREFCNT_inc(ke[i].udata));
        PUSHs(sv_2mortal(newRV_noinc((SV*)array)));
    }
    
    Safefree(ke);
