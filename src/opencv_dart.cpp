/*
    Created by Rainyl.
    Licensed: Apache 2.0 license. Copyright (c) 2024 Rainyl.
*/

#include "opencv_dart.h"

int32_t addtest(int32_t a, int32_t b) {
#ifdef DEBUG
  printf("Adding %i and %i.\n", a, b);
#endif
  return a + b;
}
