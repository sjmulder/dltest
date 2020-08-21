#include <stdio.h>
#include <dlfcn.h>

int
main(int argc, char **argv)
{
	int flags;
	void *dl;

	if (argc != 2) {
		fputs("usage: dltest <path>\n", stderr);
		return 64;
	}

	flags = RTLD_LAZY;
#ifdef RTLD_NOLOAD
	flags |= RTLD_NOLOAD;
#endif

	if (!(dl = dlopen(argv[1], RTLD_LAZY))) {
		fprintf(stderr, "%s\n", dlerror());
		return 1;
	}

	dlclose(dl);
	return 0;
}
