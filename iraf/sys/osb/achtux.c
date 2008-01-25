/* Copyright(c) 1986 Association of Universities for Research in Astronomy Inc.
 */

#define import_spp
#define import_knames
#include <iraf.h>

/* ACHTU_ -- Unpack an unsigned short integer array into an SPP datatype.
 * [MACHDEP]: The underscore appended to the procedure name is OS dependent.
 */
int ACHTUX ( XUSHORT *a, XCOMPLEX *b, XINT *npix )
{
	XUSHORT *ip;
	XCOMPLEX *op;

	if ( sizeof(*ip) < sizeof(*op) ) {
	    for ( ip = a + *npix, op = b + *npix ; b < op ; ) {
		--op; --ip;
		op->r = (float) *ip;
		op->i = 0;
	    }
	} else {
	    XCOMPLEX *maxop = b + *npix -1;
	    for ( ip=a, op=b ; op <= maxop ; op++, ip++ ) {
		op->r = (float) *ip;
		op->i = 0;
	    }
	}

	return 0;
}
