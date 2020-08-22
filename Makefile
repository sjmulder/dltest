DESTDIR?=
PREFIX?=	/usr/local
MANPREFIX?=	${PREFIX}/man

CFLAGS+=	-Wall

all: dltest

clean:
	rm -f dltest

check: all
	./dltest libc.so libc.dylib >/dev/null 2>&1
	./dltest -q libc.so libc.dylib
	! ./dltest -aq libc.so libc.dylib

install: all
	install -d ${DESTDIR}${PREFIX}/bin ${DESTDIR}${MANPREFIX}/man1
	install -m755 dltest ${DESTDIR}${PREFIX}/bin
	install -m644 dltest.1 ${DESTDIR}${MANPREFIX}/man1

uninstall:
	rm -f ${DESTDIR}${PREFIX}/bin/dltest
	rm -f ${DESTDIR}${MANPREFIX}/man1/dltest.1

.PHONY: all clean check install uninstall
