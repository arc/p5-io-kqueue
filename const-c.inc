#define PERL_constant_NOTFOUND	1
#define PERL_constant_NOTDEF	2
#define PERL_constant_ISIV	3
#define PERL_constant_ISNO	4
#define PERL_constant_ISNV	5
#define PERL_constant_ISPV	6
#define PERL_constant_ISPVN	7
#define PERL_constant_ISSV	8
#define PERL_constant_ISUNDEF	9
#define PERL_constant_ISUV	10
#define PERL_constant_ISYES	11

#ifndef NVTYPE
typedef double NV; /* 5.6 and later define NVTYPE, and typedef NV to it.  */
#endif
#ifndef aTHX_
#define aTHX_ /* 5.6 or later define this for threading support.  */
#endif
#ifndef pTHX_
#define pTHX_ /* 5.6 or later define this for threading support.  */
#endif

static int
constant_9 (pTHX_ const char *name, IV *iv_return) {
  /* When generated this function returned values for the list of names given
     here.  However, subsequent manual editing may have added or removed some.
     EVFILT_FS EV_DELETE EV_ENABLE */
  /* Offset 3 gives the best switch position.  */
  switch (name[3]) {
  case 'D':
    if (memEQ(name, "EV_DELETE", 9)) {
    /*                  ^           */
#ifdef EV_DELETE
      *iv_return = EV_DELETE;
      return PERL_constant_ISIV;
#else
      return PERL_constant_NOTDEF;
#endif
    }
    break;
  case 'E':
    if (memEQ(name, "EV_ENABLE", 9)) {
    /*                  ^           */
#ifdef EV_ENABLE
      *iv_return = EV_ENABLE;
      return PERL_constant_ISIV;
#else
      return PERL_constant_NOTDEF;
#endif
    }
    break;
  case 'I':
    if (memEQ(name, "EVFILT_FS", 9)) {
    /*                  ^           */
#ifdef EVFILT_FS
      *iv_return = EVFILT_FS;
      return PERL_constant_ISIV;
#else
      return PERL_constant_NOTDEF;
#endif
    }
    break;
  }
  return PERL_constant_NOTFOUND;
}

static int
constant_12 (pTHX_ const char *name, IV *iv_return) {
  /* When generated this function returned values for the list of names given
     here.  However, subsequent manual editing may have added or removed some.
     EVFILT_TIMER EVFILT_VNODE EVFILT_WRITE */
  /* Offset 7 gives the best switch position.  */
  switch (name[7]) {
  case 'T':
    if (memEQ(name, "EVFILT_TIMER", 12)) {
    /*                      ^           */
#ifdef EVFILT_TIMER
      *iv_return = EVFILT_TIMER;
      return PERL_constant_ISIV;
#else
      return PERL_constant_NOTDEF;
#endif
    }
    break;
  case 'V':
    if (memEQ(name, "EVFILT_VNODE", 12)) {
    /*                      ^           */
#ifdef EVFILT_VNODE
      *iv_return = EVFILT_VNODE;
      return PERL_constant_ISIV;
#else
      return PERL_constant_NOTDEF;
#endif
    }
    break;
  case 'W':
    if (memEQ(name, "EVFILT_WRITE", 12)) {
    /*                      ^           */
#ifdef EVFILT_WRITE
      *iv_return = EVFILT_WRITE;
      return PERL_constant_ISIV;
#else
      return PERL_constant_NOTDEF;
#endif
    }
    break;
  }
  return PERL_constant_NOTFOUND;
}

static int
constant (pTHX_ const char *name, STRLEN len, IV *iv_return) {
  /* Initially switch on the length of the name.  */
  /* When generated this function returned values for the list of names given
     in this section of perl code.  Rather than manually editing these functions
     to add or remove constants, which would result in this comment and section
     of code becoming inaccurate, we recommend that you edit this section of
     code, and use it to regenerate a new set of constant functions which you
     then use to replace the originals.

     Regenerate these constant functions by feeding this entire source file to
     perl -x

#!/usr/bin/perl -w
use ExtUtils::Constant qw (constant_types C_constant XS_constant);

my $types = {map {($_, 1)} qw(IV)};
my @names = (qw(EVFILT_FS EVFILT_PROC EVFILT_READ EVFILT_SIGNAL EVFILT_TIMER
	       EVFILT_VNODE EVFILT_WRITE EV_ADD EV_CLEAR EV_DELETE EV_DISABLE
	       EV_ENABLE EV_EOF EV_ERROR EV_ONESHOT));

print constant_types(); # macro defs
foreach (C_constant ("IO::KQueue", 'constant', 'IV', $types, undef, 3, @names) ) {
    print $_, "\n"; # C constant subs
}
print "#### XS Section:\n";
print XS_constant ("IO::KQueue", $types);
__END__
   */

  switch (len) {
  case 6:
    /* Names all of length 6.  */
    /* EV_ADD EV_EOF */
    /* Offset 5 gives the best switch position.  */
    switch (name[5]) {
    case 'D':
      if (memEQ(name, "EV_AD", 5)) {
      /*                    D     */
#ifdef EV_ADD
        *iv_return = EV_ADD;
        return PERL_constant_ISIV;
#else
        return PERL_constant_NOTDEF;
#endif
      }
      break;
    case 'F':
      if (memEQ(name, "EV_EO", 5)) {
      /*                    F     */
#ifdef EV_EOF
        *iv_return = EV_EOF;
        return PERL_constant_ISIV;
#else
        return PERL_constant_NOTDEF;
#endif
      }
      break;
    }
    break;
  case 8:
    /* Names all of length 8.  */
    /* EV_CLEAR EV_ERROR */
    /* Offset 3 gives the best switch position.  */
    switch (name[3]) {
    case 'C':
      if (memEQ(name, "EV_CLEAR", 8)) {
      /*                  ^          */
#ifdef EV_CLEAR
        *iv_return = EV_CLEAR;
        return PERL_constant_ISIV;
#else
        return PERL_constant_NOTDEF;
#endif
      }
      break;
    case 'E':
      if (memEQ(name, "EV_ERROR", 8)) {
      /*                  ^          */
#ifdef EV_ERROR
        *iv_return = EV_ERROR;
        return PERL_constant_ISIV;
#else
        return PERL_constant_NOTDEF;
#endif
      }
      break;
    }
    break;
  case 9:
    return constant_9 (aTHX_ name, iv_return);
    break;
  case 10:
    /* Names all of length 10.  */
    /* EV_DISABLE EV_ONESHOT */
    /* Offset 8 gives the best switch position.  */
    switch (name[8]) {
    case 'L':
      if (memEQ(name, "EV_DISABLE", 10)) {
      /*                       ^        */
#ifdef EV_DISABLE
        *iv_return = EV_DISABLE;
        return PERL_constant_ISIV;
#else
        return PERL_constant_NOTDEF;
#endif
      }
      break;
    case 'O':
      if (memEQ(name, "EV_ONESHOT", 10)) {
      /*                       ^        */
#ifdef EV_ONESHOT
        *iv_return = EV_ONESHOT;
        return PERL_constant_ISIV;
#else
        return PERL_constant_NOTDEF;
#endif
      }
      break;
    }
    break;
  case 11:
    /* Names all of length 11.  */
    /* EVFILT_PROC EVFILT_READ */
    /* Offset 10 gives the best switch position.  */
    switch (name[10]) {
    case 'C':
      if (memEQ(name, "EVFILT_PRO", 10)) {
      /*                         C      */
#ifdef EVFILT_PROC
        *iv_return = EVFILT_PROC;
        return PERL_constant_ISIV;
#else
        return PERL_constant_NOTDEF;
#endif
      }
      break;
    case 'D':
      if (memEQ(name, "EVFILT_REA", 10)) {
      /*                         D      */
#ifdef EVFILT_READ
        *iv_return = EVFILT_READ;
        return PERL_constant_ISIV;
#else
        return PERL_constant_NOTDEF;
#endif
      }
      break;
    }
    break;
  case 12:
    return constant_12 (aTHX_ name, iv_return);
    break;
  case 13:
    if (memEQ(name, "EVFILT_SIGNAL", 13)) {
#ifdef EVFILT_SIGNAL
      *iv_return = EVFILT_SIGNAL;
      return PERL_constant_ISIV;
#else
      return PERL_constant_NOTDEF;
#endif
    }
    break;
  }
  return PERL_constant_NOTFOUND;
}

