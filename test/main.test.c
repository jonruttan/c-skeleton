#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include "test-runner.h"

int _retval = 0;
const char *_greet = NULL;
#define puts(s) (_greet = (s), _retval)

#include "../src/main.c"

static char *test_greet(void)
{
	char *s = "hello";

	_retval = rand();
	_it_should("return zero", _retval == puts(s));
	_it_should("output greeting", s == _greet);

	return NULL;
}

static char *run_tests()
{
	_run_test(test_greet);

	return NULL;
}
