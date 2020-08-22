#include <stdio.h>
#include <getopt.h>
#include <dlfcn.h>

#ifdef RTLD_NOLOAD
# define DLFLAGS	(RTLD_LAZY | RTLD_NOLOAD)
#else
# define DLFLAGS	(RTLD_LAZY)
#endif

#ifdef __APPLE__
# include <AvailabilityMacros.h>
# if MAC_OS_X_VERSION_MIN_REQUIRED >= 1050
#  define HAVE_PREFLIGHT
# endif
#endif

int
main(int argc, char **argv)
{
	int opt_quiet = 0, opt_all = 0;
	int ch, ok, num_ok = 0;
#ifndef HAVE_PREFLIGHT
	void *dl;
#endif

	while ((ch = getopt(argc, argv, "aq")) != -1) {
		switch (ch) {
			case 'a': opt_all = 1; break;
			case 'q': opt_quiet = 1; break;
			default: return 64;
		}
	}

	argc -= optind;
	argv += optind;

	if (!argc) {
		fputs("usage: dltest library [...]", stderr);
		return 64;
	}

	for (; *argv; argv++) {
#ifdef HAVE_PREFLIGHT
		ok = dlopen_preflight(*argv);
#else
		if (!(ok = dl = dlopen(*argv, DLFLAGS)))
			dlclose(dl);
#endif
		if (ok)
			num_ok++;

		if (ok && !opt_quiet)
			puts(*argv);
		else if (!ok && !opt_quiet)
			fprintf(stderr, "%s\n", dlerror());

	}

	return !(opt_all ? (num_ok == argc) : num_ok);
}
