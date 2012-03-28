PRO histo_gauss_fit_event, ev        ; event handler
  COMMON global, histo_pts, y, z, num_gcc, count_corr, v_bins, comp_interp                                 ; global variables
  widget_control, ev.id, get_uvalue=uvalue                        ; get the uvalue
  widget_control, ev.top, get_uvalue=state

  CASE uvalue OF   
    'gclfbin_table' : BEGIN

	 END

    'load_phot' : BEGIN
	  photom_file=Dialog_Pickfile(Filter='*.*', /Read)
	  openr,1,photom_file
	  readf,1,zp_v_tmp
	  readf,1,zp_v_err_tmp
	  readf,1,zp_bv_tmp
	  readf,1,zp_bv_err_tmp
	  readf,1,zp_vr_tmp
	  readf,1,zp_vr_err_tmp
	  readf,1,eps_bv_tmp
	  readf,1,eps_bv_err_tmp
	  readf,1,mu_bv_tmp
	  readf,1,mu_bv_err_tmp
	  readf,1,mu_vr_tmp
	  readf,1,mu_vr_err_tmp
	  readf,1,kb_tmp
	  readf,1,kv_tmp
	  readf,1,kr_tmp
	  readf,1,b_offset_tmp
	  readf,1,v_offset_tmp
	  readf,1,r_offset_tmp
	  close,1

	  WIDGET_CONTROL, state.zp_v, SET_VALUE=STRING(zp_v_tmp)
	  WIDGET_CONTROL, state.zp_bv, SET_VALUE=STRING(zp_bv_tmp)
	  WIDGET_CONTROL, state.zp_vr, SET_VALUE=STRING(zp_vr_tmp)
	  WIDGET_CONTROL, state.eps_bv, SET_VALUE=STRING(eps_bv_tmp)	 
	  WIDGET_CONTROL, state.mu_bv, SET_VALUE=STRING(mu_bv_tmp)
	  WIDGET_CONTROL, state.mu_vr, SET_VALUE=STRING(mu_vr_tmp)
	  WIDGET_CONTROL, state.kb, SET_VALUE=STRING(kb_tmp)
	  WIDGET_CONTROL, state.kv, SET_VALUE=STRING(kv_tmp)
	  WIDGET_CONTROL, state.kr, SET_VALUE=STRING(kr_tmp)
	  WIDGET_CONTROL, state.b_offset, SET_VALUE=STRING(b_offset_tmp)
	  WIDGET_CONTROL, state.v_offset, SET_VALUE=STRING(v_offset_tmp)
	  WIDGET_CONTROL, state.r_offset, SET_VALUE=STRING(r_offset_tmp)
	 END

    'load' : BEGIN
          junk = ' '
	  gcc_file=Dialog_Pickfile(Filter='*.*', /Read)
	  openr,1,gcc_file
	  gcc_data=FLTARR(20,1000) 
	  S=FLTARR(20,1)      
          readf,1,junk
          readf,1,junk
	  ON_IOERROR,ers     
	  n=0 ; 
	  WHILE n LT 1000 DO BEGIN 
	      READF,1,S   
	    
	      gcc_data[*,n]=S     
	      n=n+1        
	  ENDWHILE         
	  ers: CLOSE,1        
	  gcc_data=gcc_data[*,0:n-1]  
	  WIDGET_CONTROL, state.gccs_loaded, SET_VALUE='GCCs loaded'
	  num_gcc = n
          WIDGET_CONTROL, state.gcc_table, SET_VALUE=gcc_data
          WIDGET_CONTROL, state.gcc_table, TABLE_XSIZE=20
          WIDGET_CONTROL, state.gcc_table, TABLE_YSIZE=n
          labels =['name/id','bx','by','am_b','b_i','err','vx','vy','am_v','v_i','err','rx','ry','am_r','r_i','err','V','B-V','V-R','r']
          WIDGET_CONTROL, state.gcc_table, COLUMN_LABELS=labels
        END

  'load_b' : BEGIN
	  junk = ' '
	  b_file=Dialog_Pickfile(Filter='*.*', /Read)
	  openr,1,b_file
	  b_comp = FLTARR(2,100)
	  S = FLTARR(2,1)
          readf,1,junk
          readf,1,junk
          readf,1,junk	  
	  ON_IOERROR,ers2  
	  n=0 ; 
	  WHILE n LT 1000 DO BEGIN 
	      READF,1,S   
	    
	      b_comp[*,n]=S     
	      n=n+1        
	  ENDWHILE       
	  ers2: CLOSE,1        
	  b_comp=b_comp[*,0:n-1]  

	  WIDGET_CONTROL, state.gcc_table, GET_VALUE=bairmass, USE_TABLE_SELECT=[3,0,3,1]
	  WIDGET_CONTROL, state.b_offset, GET_VALUE=b_offset
	  WIDGET_CONTROL, state.kb, GET_VALUE=kb

	  kb = float(kb[0])
	  b_offset = float(b_offset[0])
	  bairmass = float(bairmass[0])

	  b_comp[0,*] = (b_comp[0,*] - (kb*bairmass)) + b_offset

	  WIDGET_CONTROL, state.b_comp_table, SET_VALUE=b_comp
          WIDGET_CONTROL, state.b_comp_table, TABLE_XSIZE=2
          WIDGET_CONTROL, state.b_comp_table, TABLE_YSIZE=n
	  labels =['mag', 'completeness']
          WIDGET_CONTROL, state.b_comp_table, COLUMN_LABELS=labels
	  WIDGET_CONTROL, state.b_comp_loaded, SET_VALUE='B Completeness loaded'
	END

  'load_v' : BEGIN
	  junk = ' '
	  v_file=Dialog_Pickfile(Filter='*.*', /Read)
	  openr,1,v_file
	  v_comp = FLTARR(2,100)
	  S = FLTARR(2,1)
          readf,1,junk
          readf,1,junk
          readf,1,junk	  
	  ON_IOERROR,ers3  
	  n=0 ; 
	  WHILE n LT 1000 DO BEGIN 
	      READF,1,S   
	    
	      v_comp[*,n]=S     
	      n=n+1        
	  ENDWHILE       
	  ers3: CLOSE,1        
	  v_comp=v_comp[*,0:n-1]  

	  WIDGET_CONTROL, state.kv, GET_VALUE=kv
	  WIDGET_CONTROL, state.v_offset, GET_VALUE=v_offset
	  WIDGET_CONTROL, state.eps_bv, GET_VALUE=eps_bv
	  WIDGET_CONTROL, state.med_bmv, GET_VALUE=med_bmv
	  WIDGET_CONTROL, state.zp_v, GET_VALUE=zp_v
	  WIDGET_CONTROL, state.gcc_table, GET_VALUE=vairmass, USE_TABLE_SELECT=[8,0,8,1]

	  kv = float(kv[0])
	  v_offset = float(v_offset[0])
	  eps_bv = float(eps_bv[0])
	  med_bmv = float(med_bmv[0])
	  zp_v = float(zp_v[0])
	  vairmass = float(vairmass[0,0])

	  v_comp[0,*] = ((v_comp[0,*] - (kv*vairmass))+v_offset) + (eps_bv*med_bmv) + zp_v

	  WIDGET_CONTROL, state.v_comp_table, SET_VALUE=v_comp
          WIDGET_CONTROL, state.v_comp_table, TABLE_XSIZE=2
          WIDGET_CONTROL, state.v_comp_table, TABLE_YSIZE=n
	  labels =['mag', 'completeness']
          WIDGET_CONTROL, state.v_comp_table, COLUMN_LABELS=labels
	  WIDGET_CONTROL, state.v_comp_loaded, SET_VALUE='V Completeness loaded'
	END

  'load_r' : BEGIN
	  junk = ' '
	  r_file=Dialog_Pickfile(Filter='*.*', /Read)
	  openr,1,r_file
	  r_comp = FLTARR(2,100)
	  S = FLTARR(2,1)
          readf,1,junk
          readf,1,junk
          readf,1,junk	  
	  ON_IOERROR,ers4  
	  n=0 ; 
	  WHILE n LT 1000 DO BEGIN 
	      READF,1,S   
	    
	      r_comp[*,n]=S     
	      n=n+1        
	  ENDWHILE       
	  ers4: CLOSE,1        
	  r_comp=r_comp[*,0:n-1] 

	  WIDGET_CONTROL, state.gcc_table, GET_VALUE=rairmass, USE_TABLE_SELECT=[13,0,13,1]
	  WIDGET_CONTROL, state.r_offset, GET_VALUE=r_offset
	  WIDGET_CONTROL, state.kr, GET_VALUE=kr

	  kr = float(kr[0])
	  r_offset = float(r_offset[0])
	  rairmass = float(rairmass[0])

	  r_comp[0,*] = (r_comp[0,*] - (kr*rairmass)) + r_offset
 
	  WIDGET_CONTROL, state.r_comp_table, SET_VALUE=r_comp
          WIDGET_CONTROL, state.r_comp_table, TABLE_XSIZE=2
          WIDGET_CONTROL, state.r_comp_table, TABLE_YSIZE=n
	  labels =['mag', 'completeness']
          WIDGET_CONTROL, state.r_comp_table, COLUMN_LABELS=labels
	  WIDGET_CONTROL, state.r_comp_loaded, SET_VALUE='R Completeness loaded'
	END

     'load_mask': BEGIN
	  mask_file=Dialog_Pickfile(Filter='*.fits', /Read)
          FITS_READ, mask_file, data
	  imsize=size(data)
	  pixel_scale = 0.141
	  WIDGET_CONTROL, state.mask_bin_w, GET_VALUE=bin_width
          bin_width = float(bin_width[0])
          bin_width=bin_width*60/pixel_scale
	  WIDGET_CONTROL, state.mask_inner_e, GET_VALUE=inner_edge
          inner_edge = float(inner_edge[0])
          inner_edge=inner_edge*60/pixel_scale
	  WIDGET_CONTROL, state.galaxy_x, GET_VALUE=gal_x
          WIDGET_CONTROL, state.galaxy_y, GET_VALUE=gal_y
	  WIDGET_CONTROL, state.contamination, GET_VALUE=contam
	  WIDGET_CONTROL, state.mask_num_bins, GET_VALUE=temp_bins
	  flag=0
	  x_size = imsize[1]
	  y_size = imsize[2]
          gal_x = long(gal_x[0])
          gal_y = long(gal_y[0])
          n_bins = long(temp_bins[0])
	  bin_size=FLTARR(n_bins)
	  bin_area=FLTARR(n_bins)
          bins = FLTARR(8,n_bins)
	  contam = float(contam[0])

          for z=0,n_bins-1 do begin
            bins[0,z] = bin_width*z+inner_edge
            bins[1,z] = bin_width*(z+1)+inner_edge
          endfor

	    for x=0,x_size-1 do begin
	      for y=0,y_size-1 do begin
		if data[x,y] ne flag then BEGIN
		dist = ((gal_x-x)^2.) + ((gal_y-y)^2.)
		dist = sqrt(dist)

		for z=0,n_bins-1 do begin
		  if((dist ge bins[0,z]) and (dist lt bins[1,z])) then begin
                    bins[2,z] = bins[2,z] + dist
		    bins[3,z] = bins[3,z] + 1.0
		    data[x,y] = z+100
		    z = n_bins
		  endif
		endfor
		endif
	      endfor
	    endfor

	  n = num_gcc - 1
          WIDGET_CONTROL, state.gcc_table, GET_VALUE=temp_dist, USE_TABLE_SELECT=[19,0,19,n]
          bins[6,*] = 0.0
          dist = float(temp_dist[0,*])*60./0.141
          for g=0,n do begin
            for z=0,n_bins-1 do begin
               if((dist[g] ge bins[0,z]) and (dist[g] lt bins[1,z])) then begin
		    bins[6,z] = bins[6,z] + 1.0
		    z = n_bins
	       endif
            endfor
          endfor

	  for j=0,n_bins-1 do begin
            bins[2,j] = bins[2,j]/bins[3,j]
	    bins[4,j] = bins[1,j]^2. * 3.14159 - bins[0,j]^2. * 3.14159
            bins[5,j] = bins[3,j]/bins[4,j]
	    
	    temp_cf = (contam * bins[3,j] * .141 * .141 / 3600) / bins[6,j]
	    if(temp_cf gt 1.0) then begin
	      temp_cf = 1.0
	    endif
	    
	    bins[7,j] = temp_cf

	  endfor

          labels = ['Inner Edge', 'Outer Edge', 'Avg Distance', 'Unmasked Area', 'Total Bin Area', 'Unmasked Fraction', 'N (gcc)', 'Contamination']
          WIDGET_CONTROL, state.bins_table, SET_VALUE=bins
	  WIDGET_CONTROL, state.bins_table, TABLE_YSIZE=n_bins
	  WIDGET_CONTROL, state.bins_table, TABLE_XSIZE=8
	  WIDGET_CONTROL, state.bins_table, COLUMN_LABELS=labels

	  WIDGET_CONTROL, state.gcc_table, GET_VALUE=temp_v, USE_TABLE_SELECT=[16,0,16,n]	
	  WIDGET_CONTROL, state.gcc_table, TABLE_XSIZE=21
	  count_corr = FLTARR(2,n+1)
	  count_corr[0,*] = 0.0
          v_mag = float(temp_v)
          for g=0,n do begin
	    count_corr[1,g] = v_mag[g]
            for z=0,n_bins-1 do begin
               if((dist[g] ge bins[0,z]) and (dist[g] lt bins[1,z])) then begin
		    count_corr[0,g] = 1 - bins[7,z]
	       endif 
            endfor
          endfor
      END

  'bin_mags' : BEGIN
	widget_control, state.binsize_txt, GET_VALUE=binsize
	widget_control, state.maxbin_txt, GET_VALUE=maxbin
	widget_control, state.minbin_txt, GET_VALUE=minbin

	binsize = float(binsize[0])
	maxbin = float(maxbin[0])
	minbin = float(minbin[0])

	num_bins = long((maxbin - minbin) / binsize)
	y = size(count_corr)
	n_gccs = y[2]
	v_bins = FLTARR(2,num_bins)

	for i=0,num_bins-1 do begin
	    v_bins[0,i] = minbin + binsize * i + binsize/2.0
	    v_bins[1,i] = 0.0
	endfor

	for g=0,n_gccs-1 do begin
	  for i=0,num_bins-1 do begin
	    if((count_corr[1,g] gt (minbin + binsize * (i))) and (count_corr[1,g] lt (minbin + binsize * (i+1)))) then begin
	      v_bins[1,i] = v_bins[1,i] + count_corr[0,g]
	    endif
	  endfor
	endfor

      END

  'calc_comp' : BEGIN
	  WIDGET_CONTROL, state.v_comp_table, GET_VALUE=v_comp
	  WIDGET_CONTROL, state.r_comp_table, GET_VALUE=r_comp
	  WIDGET_CONTROL, state.b_comp_table, GET_VALUE=b_comp

	  WIDGET_CONTROL, state.eps_bv, GET_VALUE=eps_bv
	  WIDGET_CONTROL, state.med_bmv, GET_VALUE=med_bmv
	  WIDGET_CONTROL, state.zp_v, GET_VALUE=zp_v
	  WIDGET_CONTROL, state.zp_bv, GET_VALUE=zp_bv
	  WIDGET_CONTROL, state.zp_vr, GET_VALUE=zp_vr
	  WIDGET_CONTROL, state.mu_bv, GET_VALUE=mu_bv
	  WIDGET_CONTROL, state.mu_vr, GET_VALUE=mu_vr

	  eps_bv = float(eps_bv[0])
	  med_bmv = float(med_bmv[0])
	  zp_v = float(zp_v[0])
	  mu_bv = float(mu_bv[0])
	  zp_bv = float(zp_bv[0])
	  zp_vr = float(zp_vr[0])
	  mu_vr = float(mu_vr[0])

	  n_tmp = size(v_comp)
	  n_comp = n_tmp[2]

	  n_tmp = size(v_bins)
	  n_bins = n_tmp[2]

	  comp_interp = fltarr(8,n_bins) 
	  comp_interp[*,*] = 0.0

	  for k=0,n_bins-1 do begin

	    comp_interp[0,k] = v_bins[0,k]
	    comp_interp[5,k] = v_bins[1,k]

	    for j=0,n_comp-2 do begin
	      if( v_bins[0,k] lt v_comp[0,0]) then begin
		comp_interp[1,k] = 1.0
	      endif else begin if ((v_bins[0,k] gt v_comp[0,j]) and (v_bins[0,k] le v_comp[0,j+1])) then begin
		tmp1 = (v_bins[0,k] - v_comp[0,j]) / (v_comp[0,j+1] - v_comp[0,j])
		tmp2 = (v_comp[1,j]-v_comp[1,j+1]) * tmp1
		comp_interp[1,k] = v_comp[1,j] - tmp2
	      endif
	      endelse
	    endfor
	  
	    for bmv=0.55,1.05,0.1 do begin
	      v0 = v_bins[0,k] - (eps_bv*(bmv)) - zp_v
	      b0 = ((bmv - zp_bv) / mu_bv) + v0
	      for j=0,n_comp-2 do begin
		if (b0 lt b_comp[0,j]) then begin
		    comp_interp[2,k] = comp_interp[2,k] + 0.2
		    j = n_comp-2
		endif else begin if (b0 gt b_comp[0,j] and b0 le b_comp[0,j+1]) then begin
		  tmp1 = (b0 - b_comp[0,j]) / (b_comp[0,j+1] - b_comp[0,j])
		  tmp2 = (b_comp[1,j]-b_comp[1,j+1]) * tmp1
		  comp_interp[2,k] = comp_interp[2,k] + 0.2 * (b_comp[1,j] - tmp2)
		  j = n_comp-2
		endif
		endelse
	      endfor
	    endfor

	    for vmr=0.34,0.6,0.065 do begin
	      v0 = v_bins[0,k] - (eps_bv*(med_bmv)) - zp_v
	      r0 = v0 - ((vmr - zp_vr)/mu_vr)
	      for j=0,n_comp-2 do begin
		if (r0 lt r_comp[0,j]) then begin
		    comp_interp[3,k] = comp_interp[3,k] + 0.2
		    j = n_comp-2
		endif else begin if ((r0 gt r_comp[0,j] and (r0 le r_comp[0,j+1]))) then begin
		 
		  tmp1 = (r0 - r_comp[0,j]) / (r_comp[0,j+1] - r_comp[0,j])
		  tmp2 = (r_comp[1,j]-r_comp[1,j+1]) * tmp1
		  comp_interp[3,k] = comp_interp[3,k] + 0.2 * (r_comp[1,j] - tmp2)
		  j = n_comp-2
		endif
		endelse
	      endfor
	    endfor

	  comp_interp[4,k] = comp_interp[1,k] * comp_interp[2,k] * comp_interp[3,k]
	  comp_interp[6,k] = comp_interp[5,k] / comp_interp[4,k]

	  endfor

	  WIDGET_CONTROL, state.gclfbin_table, TABLE_YSIZE=n_bins
	  WIDGET_CONTROL, state.gclfbin_table, TABLE_XSIZE=8
	  WIDGET_CONTROL, state.gclfbin_table, SET_VALUE=comp_interp
	  WIDGET_CONTROL, state.gclfbin_table, /EDITABLE, USE_TABLE_SELECT=[7,0,7,n_bins-1]
      END
	
  'plot'  : BEGIN
	x = comp_interp[5,*]
	y = comp_interp[6,*]
	z = comp_interp[0,*]
        plot,z,y,psym=10
	oplot,z,x,psym=10
       END
  'quit'  : widget_control, ev.top, /destroy

  'fit'  :  BEGIN
      widget_control, state.maxbin_txt, Get_Value=upper_limit
      widget_control, state.minbin_txt, Get_Value=lower_limit
      widget_control, state.peak_txt, Get_Value=peak
      widget_control, state.area_txt, Get_Value=area
      WIDGET_CONTROL, state.gclfbin_table, GET_VALUE=comp_interp
      z = comp_interp[0,*]
      x = comp_interp[5,*]
      y = comp_interp[6,*]
      w = comp_interp[7,*]
      upper_limit = float(upper_limit[0])
      lower_limit = float(lower_limit[0])
      weight=z
      loc=where(comp_interp[7,*] > 0,complement=oloc)
      print,loc
      print,z,x,y
      weight[loc] = 1
      weight[oloc] = 0

  pi = replicate({value:0.D, fixed:0, limited:[0,0], $
			limits:[0.D,0]}, 3)
    pi[0].fixed = 1
    pi[1].fixed = 1
    pi[*].value = [peak, 1.2D, area]

  fitdata1=MPFITFUN('mygauss',z,y,1,weights=weight,parinfo=pi)

  pi[*].value = [peak,1.3D, area]

  fitdata2=MPFITFUN('mygauss',z,y,1,weights=weight,parinfo=pi)

  pi[*].value = [peak,1.4D, area]

  fitdata3=MPFITFUN('mygauss',z,y,1,weights=weight,parinfo=pi)

  m = indgen(500)
  oplot, m/10.0, gauss1(m/10.0, fitdata1(0:2)), color=90, thick=5
 
  oplot, m/10.0, gauss1(m/10.0, fitdata2(0:2)), color=120, thick=5
 
  oplot, m/10.0, gauss1(m/10.0, fitdata3(0:2)), color=150, thick=5

  binsize = z[1] - z[0]
  openw,1,"idl_histo.out",/APPEND
  total_n = total(x)
  printf,1,'Binsize = ',binsize
  printf,1,'Starting bin = ',lower_limit 
  printf,1,'Covering Fraction'
  printf,1,'================='
  printf,1,'1.2 = ',total_n/(fitdata1[2]*1/binsize)
  printf,1,'1.3 = ',total_n/(fitdata2[2]*1/binsize)
  printf,1,'1.4 = ',total_n/(fitdata3[2]*1/binsize)
  printf,1,''
  printf,1,'Total Number of GCCs: ',total_n
  close,1
     END

  END
END

PRO histo_gauss_fit
  COMMON global, histo_pts, y, z
  main = widget_base (title='Histogram Gaussian Fitting', /row)             ; main base
  cnt1 = widget_base (main, /column)
  cnt2 = widget_base (main, /column)
  cnt3 = widget_base (main, /column)
  data_base = widget_base (main, /column)
  load_btn = widget_button (cnt1, uvalue='load', value='Load GCCs')
  load_phot = widget_button (cnt1, uvalue='load_phot', value='Load Photometric Calibration')
  load_b = widget_button (cnt1, uvalue='load_b', value='Load B Completeness')
  load_v = widget_button (cnt1, uvalue='load_v', value='Load V Completeness')
  load_r = widget_button (cnt1, uvalue='load_r', value='Load R Completeness')
  load_mask = WIDGET_BUTTON (cnt1, uvalue='load_mask', value='Load masked .fits and create bins')
  bin_mags =  WIDGET_BUTTON (cnt1, uvalue='bin_mags', value='Bin GCCs by V Magnitude')
  calc_comp = WIDGET_BUTTON (cnt1, uvalue='calc_comp', value='Calculate Completeness')
  plot_btn = widget_button (cnt1, uvalue='plot', value='Plot Histogram')
  fit_btn  = widget_button (cnt1, uvalue='fit', value='Fit Gaussian')      
  quit = widget_button (cnt1, uvalue='quit', value='Quit')
  
  checklist_label = WIDGET_LABEL(cnt1, VALUE='Checklist', UVALUE='checklist_label')
  gccs_loaded = WIDGET_LABEL(cnt1, VALUE='GCCs NOT loaded', UVALUE='gccs_loaded')
  b_comp_loaded = WIDGET_LABEL(cnt1, VALUE='B Completeness NOT loaded', UVALUE='b_comp_loaded')
  v_comp_loaded = WIDGET_LABEL(cnt1, VALUE='V Completeness NOT loaded', UVALUE='v_comp_loaded')
  r_comp_loaded = WIDGET_LABEL(cnt1, VALUE='R Completeness NOT loaded', UVALUE='r_comp_loaded')
  mask_loaded = WIDGET_LABEL(cnt1, VALUE='Mask NOT loaded', UVALUE='mask_loaded')

  cnt1_label1 = WIDGET_LABEL(cnt1, VALUE='Radial Profile')
  mask_base = WIDGET_BASE(cnt1, /row)
  mask_label_base = WIDGET_BASE(mask_base, /COLUMN)
  mask_field_base = WIDGET_BASE(mask_base, /COLUMN)
  mask_bin_w =  WIDGET_TEXT(mask_field_base, /editable, uvalue='mask_bin_w', value='0.5')
  mask_inner_e = WIDGET_TEXT(mask_field_base, /editable, uvalue='mask_inner_e', value='0.1')
  mask_num_bins = WIDGET_TEXT(mask_field_base, /editable, uvalue='mask_num_bins', value='15')
  galaxy_x = WIDGET_TEXT(mask_field_base, /editable, uvalue='galaxy_x', value='1200')
  galaxy_y = WIDGET_TEXT(mask_field_base, /editable, uvalue='galaxy_y', value='1200')
  contamination = WIDGET_TEXT(mask_field_base, /editable, uvalue='contamination', value='1.011')

  mask_label1 = WIDGET_LABEL(mask_label_base, VALUE='Bin Width')
  mask_label2 = WIDGET_LABEL(mask_label_base, VALUE='Bin Inner Edge')
  mask_label3 = WIDGET_LABEL(mask_label_base, VALUE='Number of Bins')
  mask_label4 = WIDGET_LABEL(mask_label_base, VALUE='Galaxy X')
  mask_label5 = WIDGET_LABEL(mask_label_base, VALUE='Galaxy Y')
  mask_label6 = WIDGET_LABEL(mask_label_base, VALUE='Contamination')
  bins_table = WIDGET_TABLE(cnt1, UVALUE='bins_table', XSIZE=3, YSIZE=6)

  label1 = WIDGET_LABEL(cnt3, VALUE='kb', UVALUE='label1')
  kb = WIDGET_TEXT(cnt3, /editable, uvalue='kb', value='0.25')
  label2 = WIDGET_LABEL(cnt3, VALUE='kv', UVALUE='label2')
  kv = WIDGET_TEXT(cnt3, /editable, uvalue='kb', value='0.15')
  label3 = WIDGET_LABEL(cnt3, VALUE='kr', UVALUE='label3')
  kr = WIDGET_TEXT(cnt3, /editable, uvalue='kb', value='0.10')
  label4 = WIDGET_LABEL(cnt3, VALUE='zp_v', UVALUE='label4')
  zp_v = WIDGET_TEXT(cnt3, /editable, uvalue='zp_v', value='25.97501')
  label5 = WIDGET_LABEL(cnt3, VALUE='zp_bv', UVALUE='label5')
  zp_bv = WIDGET_TEXT(cnt3, /editable, uvalue='zp_bv', value='-0.02609')
  label6 = WIDGET_LABEL(cnt3, VALUE='zp_vr', UVALUE='label6')
  zp_vr = WIDGET_TEXT(cnt3, /editable, uvalue='zp_vr', value='-0.10004')
  label7 = WIDGET_LABEL(cnt3, VALUE='eps_bv', UVALUE='label7')
  eps_bv = WIDGET_TEXT(cnt3, /editable, uvalue='eps_bv', value='0.00055408')
  label8 = WIDGET_LABEL(cnt3, VALUE='mu_bv', UVALUE='label8')
  mu_bv = WIDGET_TEXT(cnt3, /editable, uvalue='mu_bv', value='0.99176607')
  label9 = WIDGET_LABEL(cnt3, VALUE='mu_vr', UVALUE='label9')
  mu_vr = WIDGET_TEXT(cnt3, /editable, uvalue='mu_vr', value='1.01345190')
  label10 = WIDGET_LABEL(cnt3, VALUE='b_offset', UVALUE='label10')
  b_offset = WIDGET_TEXT(cnt3, /editable, uvalue='b_offset', value='-0.0687059')
  label11 = WIDGET_LABEL(cnt3, VALUE='v_offset', UVALUE='label11')
  v_offset = WIDGET_TEXT(cnt3, /editable, uvalue='v_offset', value='-0.103403')
  label12 = WIDGET_LABEL(cnt3, VALUE='r_offset', UVALUE='label12')
  r_offset = WIDGET_TEXT(cnt3, /editable, uvalue='r_offset', value='-0.100385')
  med_bmv = WIDGET_TEXT(cnt3, /editable, uvalue='med_bmv', value='0.761')


  binsize_txt = WIDGET_TEXT(cnt2, /editable, uvalue='binsize', value='0.5')
  maxbin_txt = WIDGET_TEXT(cnt2, /editable, uvalue='maxbin', value='24.0')
  minbin_txt = WIDGET_TEXT(cnt2, /editable, uvalue='minbin', value='19.0')
  peak_txt = WIDGET_TEXT(cnt2, /editable, uvalue='peak', value='1.5')
  area_txt = WIDGET_TEXT(cnt2, /editable, uvalue='area', value='100')

  gcc_table_label = WIDGET_LABEL(data_base, VALUE='GCCs', UVALUE='gcc_table_label')
  gcc_table = WIDGET_TABLE(data_base, UVALUE='gcc_table', XSIZE=8, YSIZE=6)

  comp_base = WIDGET_BASE(data_base, /row)
  comp_b_base = WIDGET_BASE(comp_base, /column)
  comp_v_base = WIDGET_BASE(comp_base, /column)
  comp_r_base = WIDGET_BASE(comp_base, /column)
  b_comp_table_label = WIDGET_LABEL(comp_b_base, VALUE='B Completeness', UVALUE='b_comp_table_label')
  b_comp_table = WIDGET_TABLE(comp_b_base, UVALUE='b_comp_table', XSIZE=2, YSIZE=4, /NO_ROW_HEADERS)
  v_comp_table_label = WIDGET_LABEL(comp_v_base, VALUE='V Completeness', UVALUE='v_comp_table_label')
  v_comp_table = WIDGET_TABLE(comp_v_base, UVALUE='v_comp_table', XSIZE=2, YSIZE=4, /NO_ROW_HEADERS)
  r_comp_table_label = WIDGET_LABEL(comp_r_base, VALUE='R Completeness', UVALUE='r_comp_table_label')
  r_comp_table = WIDGET_TABLE(comp_r_base, UVALUE='r_comp_table', XSIZE=2, YSIZE=4, /NO_ROW_HEADERS)

  bin_base = WIDGET_BASE(data_base, /column)
  gclfbin_table_label = WIDGET_LABEL(bin_base, VALUE='GCLF Bins', UVALUE='gclfbin_table_label')
  gclfbin_table = WIDGET_TABLE(bin_base, UVALUE='gclfbin_table', XSIZE=7, YSIZE=10, /NO_ROW_HEADERS)

  state = {load_phot:load_phot, gclfbin_table:gclfbin_table, calc_comp:calc_comp, bin_mags:bin_mags, contamination:contamination, bins_table:bins_table, load_mask:load_mask, mask_num_bins:mask_num_bins, mask_bin_w:mask_bin_w, mask_inner_e:mask_inner_e, galaxy_x:galaxy_x, galaxy_y:galaxy_y, b_comp_loaded:b_comp_loaded, v_comp_loaded:v_comp_loaded, r_comp_loaded:r_comp_loaded, v_comp_table:v_comp_table, r_comp_table:r_comp_table, b_comp_table:b_comp_table, kb:kb, kv:kv, kr:kr, zp_v:zp_v, zp_bv:zp_bv, zp_vr:zp_vr, eps_bv:eps_bv, mu_bv:mu_bv, mu_vr:mu_vr, b_offset:b_offset, v_offset:v_offset, r_offset:r_offset, med_bmv:med_bmv, gccs_loaded:gccs_loaded, gcc_table:gcc_table, cnt3:cnt3, data_base:data_base, cnt2:cnt2, binsize_txt:binsize_txt, maxbin_txt:maxbin_txt, minbin_txt:minbin_txt, peak_txt:peak_txt, area_txt:area_txt}
  widget_control, main, set_uvalue=state, /realize                                  ; create the widgets
  xmanager, 'histo_gauss_fit', main, /no_block 
end