# Copyright(c) 1986 Association of Universities for Research in Astronomy Inc.

include	<gset.h>
include	<mach.h>
include	<imhdr.h>
include	<mwset.h>

# T_PROW -- Plot an image row.

procedure t_prow ()

pointer	image, wcslab, fmt
pointer	im, mw, ct, sp, x_vec, y_vec
long	row
size_t	ncols, nlines
real	zmin, zmax
size_t	sz_val
long	clgetl()
pointer	immap(), mw_openim(), mw_sctran()
include	<nullptr.inc>

begin
	call smark (sp)
	sz_val = SZ_FNAME
	call salloc (image, sz_val, TY_CHAR)
	sz_val = SZ_LINE
	call salloc (wcslab, sz_val, TY_CHAR)
	call salloc (fmt, sz_val, TY_CHAR)

	# Open image
	call clgstr ("image", Memc[image], SZ_FNAME)
	im = immap (Memc[image], READ_ONLY, NULLPTR)
	call clgstr ("wcs", Memc[wcslab], SZ_LINE)
	mw = mw_openim (im)
	call mw_seti (mw, MW_USEAXMAP, NO)
	ct = mw_sctran (mw, "logical", Memc[wcslab], 0)

	ncols  = IM_LEN(im,1)
	nlines = IM_LEN(im,2)

	row = clgetl ("row")
	if (row < 1 || row > nlines) {
	    call imunmap (im)
	    call error (2, "line index references outside image")
	}

	# Get the requested row from the image.
	call malloc (x_vec, ncols, TY_REAL)
	call malloc (y_vec, ncols, TY_REAL)
	call plt_grows (im, mw, ct, row, row, Memr[x_vec], Memr[y_vec],
	    zmin, zmax, Memc[wcslab], Memc[fmt], SZ_LINE)

	# Now draw the vector to the screen.
	call pr_draw_vector (Memc[image], Memr[x_vec], Memr[y_vec], ncols,
	    zmin, zmax, row, row, Memc[wcslab], Memc[fmt], false)
       
        # Free resources.
	call mfree (x_vec, TY_REAL)
	call mfree (y_vec, TY_REAL)

	call imunmap (im)
	call sfree (sp)
end
