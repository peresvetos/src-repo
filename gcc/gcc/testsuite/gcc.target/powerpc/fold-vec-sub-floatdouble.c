/* Verify that overloaded built-ins for vec_sub with float and
   double inputs for VSX produce the right results.  */

/* { dg-do compile } */
/* { dg-require-effective-target powerpc_vsx_ok } */
/* { dg-options "-maltivec -mvsx" } */

#include <altivec.h>

vector float
test1 (vector float x, vector float y)
{
  return vec_sub (x, y);
}

vector double
test2 (vector double x, vector double y)
{
  return vec_sub (x, y);
}

/* { dg-final { scan-assembler-times "xvsubsp" 1 } } */
/* { dg-final { scan-assembler-times "xvsubdp" 1 } } */
