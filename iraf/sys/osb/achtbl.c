/* Copyright(c) 1986 Association of Universities for Research in Astronomy Inc.
 */

#define import_spp
#define import_knames
#include <iraf.h>

/* ACHTB_ -- Unpack an unsigned byte array into an SPP array.
 * The loop runs in the reverse direction so that the unpack can be
 * performed in place (a and b can be the same array).
 */
int ACHTBL ( XUBYTE *a, XLONG *b, XINT *npix )
{
	XUBYTE *ip;
	XLONG *op;

	for ( ip = a + *npix, op = b + *npix ; b < op ; ) {
	    --op; --ip;
	    *op = *ip;
	}

	return 0;
}
