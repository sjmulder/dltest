DESTDIR?=
PREFIX?=	/usr/local
MANPREFIX?=	${PREFIX}/man

CFLAGS+=	-Wall
LDLIBS+=	-ldl

all: dltest

clean:
	rm -f dltest

check: all
	./dltest libutil.so libutil.dylib
	./dltest libutil.so libutil.dylib 2>/dev/null | grep -q libutil
	./dltest libutil.so libutil.dylib 2>&1 >/dev/null | grep -q libutil
	./dltest -q libutil.so libutil.dylib
	! ./dltest -aq libutil.so libutil.dylib

install: all
	install -d ${DESTDIR}${PREFIX}/bin ${DESTDIR}${MANPREFIX}/man1
	install -m755 dltest ${DESTDIR}${PREFIX}/bin
	install -m644 dltest.1 ${DESTDIR}${MANPREFIX}/man1

uninstall:
	rm -f ${DESTDIR}${PREFIX}/bin/dltest
	rm -f ${DESTDIR}${MANPREFIX}/man1/dltest.1

.PHONY: all clean check install uninstall
