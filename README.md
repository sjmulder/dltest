dltest
=====
Test for library presence.

**dltest** [**-aq**] *library* [...]

Description
-----------
Attempt to open the given libraries using `dlopen_preflight` if
available, or `dlopen` otherwise.

Names of successfully loaded libraries are printed to standard output,
loading errors to standard error, and success is returned if *any* of the
loads was successful.

Options:

**-a**: Only return success if all of the given libraries could be
loaded.

**-q**: Don't print loaded libraries or errors.

Especially useful on macOS 11 and up which doesn't include regular shared
library files but only a precompiled shared library cache.

Exits 0 on success or 1 on failure (see description), or 64 for bad
usage.

Examples
--------
See if some libraries are available:

    $ dltest libcurses.dylib libtermcap.dylib libterminfo.dylib
    libcurses.dylib
    libtermcap.dylib
    dlopen_preflight(libterminfo.dylib): image not found

To see if we have all of them using **-a**:

    $ dltest -aq libcurses.dylib libtermcap.dylib libterminfo.dylib \
        && echo YES || echo NO
    NO

Installation
------------
Should work on any Unix, including Linux and macOS.

 1. Install C build tools if necessary.
     - **Debian** or **Ubuntu**: `apt install build-essential`
     - **macOS**: install the [Xcode Command Line Tools](
       https://developer.apple.com/xcode/resources/).
 2. Download and extract the source.
 3. Build with `make`.
 4. Install with `make install` as root (e.g. `sudo make install`).

See the Makefile for more details.

Author
------
Sijmen J. Mulder (<ik@sjmulder.nl>)
