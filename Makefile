DESTDIR?=
PREFIX?=	/usr/local
MANPREFIX?=	${PREFIX}/man

CFLAGS+=	-Wall
LDLIBS+=	-ldl

all: dltest

clean:
	rm -f dltest

check: all
	./dltest libm.so libm.dylib >/dev/null 2>&1
	./dltest libm.so libm.dylib 2>/dev/null | grep -q libm
	./dltest libm.so libm.dylib 2>&1 >/dev/null | grep -q libm
	./dltest -q libm.so libm.dylib
	! ./dltest -aq libm.so libm.dylib

install: all
	install -d ${DESTDIR}${PREFIX}/bin ${DESTDIR}${MANPREFIX}/man1
	install -m755 dltest ${DESTDIR}${PREFIX}/bin
	install -m644 dltest.1 ${DESTDIR}${MANPREFIX}/man1

uninstall:
	rm -f ${DESTDIR}${PREFIX}/bin/dltest
	rm -f ${DESTDIR}${MANPREFIX}/man1/dltest.1

.PHONY: all clean check install uninstall
