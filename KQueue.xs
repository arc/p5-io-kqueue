/* $Id: KQueue.xs,v 1.1.1.1 2005/02/17 16:49:08 matt Exp $ */

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
    void      * udata
  INIT:
    struct kevent ke;
    int i;
  PPCODE:
    memset(&ke, 0, sizeof(struct kevent));
    EV_SET(&ke, ident, filter, flags, fflags, data, udata);
    i = kevent(kq, &ke, 1, NULL, 0, NULL);
    if (i == -1) {
        croak("set kevent failed: %s", strerror(errno));
    }

void
kevent(kq, timeout=0)
    kqueue_t    kq
    I32         timeout
  INIT:
    int num_events, i;
    struct kevent *ke;
    struct timespec t;
    struct timespec *tbuf = (struct timespec *)0;
    I32 max_events = SvIV(get_sv("IO::KQueue::MAX_EVENTS", FALSE));
  PPCODE:
    dXSTARG;
    ke = calloc(max_events, sizeof(struct kevent));
    if (ke == NULL) {
        croak("malloc failed");
    }
    
    if (timeout > 0) {
        t.tv_sec = timeout / 1000;
        t.tv_nsec = (timeout % 1000) * 1000000;
        tbuf = &t;
    }
    
    num_events = kevent(kq, NULL, 0, ke, max_events, tbuf);
    
    if (num_events == -1) {
        croak("kevent error: %s", strerror(errno));
    }
    
    for (i = 0; i < num_events; i++) {
        XPUSHs(sv_2mortal(newSViv(ke[i].ident)));
        XPUSHs(sv_2mortal(newSViv(ke[i].filter)));
    }
