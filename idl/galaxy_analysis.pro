PRO galaxy_analysis_event, ev  
  COMMON global, use_additional
  WIDGET_CONTROL, ev.TOP, GET_UVALUE=state
  WIDGET_CONTROL, ev.ID, GET_UVALUE=uval  

  CASE uval OF  

    'load_gcc' : BEGIN
	  use_additional = 0
          junk = ' '
	  gcc_file=Dialog_Pickfile(Filter='*.*', /Read)
          WIDGET_CONTROL, state.gcc_data_label, SET_VALUE=gcc_file
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
          WIDGET_CONTROL, state.gcc_table, SET_VALUE=gcc_data
          WIDGET_CONTROL, state.gcc_table, TABLE_XSIZE=20
          WIDGET_CONTROL, state.gcc_table, TABLE_YSIZE=n
          labels =['name/id','bx','by','am_b','b_i','err','vx','vy','am_v','v_i','err','rx','ry','am_r','r_i','err','V','B-V','V-R','r']
          WIDGET_CONTROL, state.gcc_table, COLUMN_LABELS=labels
          WIDGET_CONTROL, state.num_gcc, SET_VALUE=STRING(n-1)
        END
     
    'plot_gcc' : BEGIN
          WIDGET_CONTROL, state.num_gcc, GET_VALUE=n
          WIDGET_CONTROL, state.gcc_table, GET_VALUE=gcc_x, USE_TABLE_SELECT=[1,0,1,n]
          WIDGET_CONTROL, state.gcc_table, GET_VALUE=gcc_y, USE_TABLE_SELECT=[2,0,2,n]
          atvplot,gcc_x,gcc_y,psym=symcat(16)
        END

    'load_add_data' : BEGIN
	  add_data_file=Dialog_Pickfile(Filter='*.*', /Read)
	  openr,1,add_data_file
	  add_data=FLTARR(3,1000) 
	  S=FLTARR(3,1)      
	  ON_IOERROR,ers3     
	  n=0 ; 
	  WHILE n LT 1000 DO BEGIN 
	      READF,1,S   
	    
	      add_data[*,n]=S     
	      n=n+1        
	  ENDWHILE         
	  ers3: CLOSE,1        
	  add_data=add_data[*,0:n-1]  
          WIDGET_CONTROL, state.add_data_table, SET_VALUE=add_data
          WIDGET_CONTROL, state.add_data_table, TABLE_XSIZE=3
          WIDGET_CONTROL, state.add_data_table, TABLE_YSIZE=n
	  use_additional = 1
        END

     'load_fits' : BEGIN
	  WIDGET_CONTROL, state.mask_file, SET_VALUE=Dialog_Pickfile(Filter='*.fits', /Read)
	  WIDGET_CONTROL, state.mask_file, GET_VALUE=fits_file
	  atv,fits_file
	END

     'quit'      : WIDGET_CONTROL, ev.TOP, /DESTROY 

     'load_bins' : BEGIN
          bins_file=Dialog_Pickfile(Filter='*.*', /Read)
          openr,1,bins_file
          WIDGET_CONTROL, state.num_bins, GET_VALUE=temp_bins
          n_bins = long(temp_bins[0])
          test = DBLARR(7,n_bins)
          readf,1,test
          close,1
          WIDGET_CONTROL, state.bins_table, SET_VALUE=test
          labels = ['Inner Edge', 'Outer Edge', 'Avg Distance', 'Unmasked Area', 'Total Bin Area', 'Unmasked Fraction', 'N (gcc)']
          WIDGET_CONTROL, state.bins_table, COLUMN_LABELS=labels
          WIDGET_CONTROL, state.bins_table, TABLE_YSIZE=n_bins
          WIDGET_CONTROL, state.bins_table, TABLE_XSIZE=7
        END

     'bin_gccs'  : BEGIN
	  WIDGET_CONTROL, state.num_bins, GET_VALUE=temp_bins
          n_bins = long(temp_bins[0])
          WIDGET_CONTROL, state.num_gcc, GET_VALUE=n_tmp
	  n = long(n_tmp[0])
          WIDGET_CONTROL, state.gcc_table, GET_VALUE=temp_dist, USE_TABLE_SELECT=[19,0,19,n]
          WIDGET_CONTROL, state.bins_table, GET_VALUE=bins
          bins[6,*] = 0.0
          dist = double(temp_dist[0,*])*60./0.1406
          for g=0,n do begin
            for z=0,n_bins-1 do begin
               if((dist[g] ge bins[0,z]) and (dist[g] lt bins[1,z])) then begin
		    bins[6,z] = bins[6,z] + 1.0
		    z = n_bins
	       endif
            endfor
          endfor
          labels = ['Inner Edge', 'Outer Edge', 'Avg Distance', 'Unmasked Area', 'Total Bin Area', 'Unmasked Fraction', 'N (gcc)']
          WIDGET_CONTROL, state.bins_table, COLUMN_LABELS=labels
          WIDGET_CONTROL, state.bins_table, SET_VALUE=bins

          labels = ['#r(arcmin)','N', 'sfc_dens','serr','log(sfc_dens)', 'lserrhi','lserrlo','good_frac','r^(1/4)', 'N(GCC)','N(contam)','contam_frac']

          WIDGET_CONTROL, state.contam, GET_VALUE=contamination
	  WIDGET_CONTROL, state.contam_err, GET_VALUE=contam_error_tmp
	  WIDGET_CONTROL, state.gclf_cover, GET_VALUE=gclf_coverage_tmp

	  contam_error = DOUBLE(contam_error_tmp[0])
	  gclf_coverage = DOUBLE(gclf_coverage_tmp[0])

          rad_profile = DBLARR(12,n_bins)
	  for z=0,n_bins-1 do begin

	      pi = 3.14159265359D
	      ngc_tmp = 0.0D
	      gf_tmp = 0.0D
	      area_tmp = 0.0D
	      dist_tmp = 0.0D

              ngc_tmp = bins[6,z]
              gf_tmp = bins[5,z]
	      area_tmp = (((bins[1,z] * .1406 / 60.)^2 * pi) - ((bins[0,z] * .1406 / 60.)^2 * pi)) * gf_tmp
              dist_tmp = bins[2,z] * .1406 / 60.
              rad_profile[9,z] = ngc_tmp
              rad_profile[10,z] = contamination * area_tmp
              rad_profile[11,z] = rad_profile[10,z]/ngc_tmp
              rad_profile[0,z] = dist_tmp
	      if(rad_profile[10,z] gt rad_profile[9,z]) then begin
		rad_profile[1,z] = ngc_tmp - rad_profile[10,z]
	      endif else begin
		rad_profile[1,z] = (ngc_tmp - rad_profile[10,z]) / gclf_coverage
	      endelse
              rad_profile[2,z] = rad_profile[1,z] / area_tmp
	      rad_profile[3,z] = (sqrt(rad_profile[9,z]+(area_tmp*contam_error)^2.) / gclf_coverage) / area_tmp
;              rad_profile[3,z] = sqrt(rad_profile[2,z])

;     asymp_den = 0.184798092
;     asymp_den_err = 0.0186323598
; 
;     ncontam[m] = ((asymp_den)*(new_area[m]))
;     newnum = numGC[m] - ncontam[m]
;     nerr = sqrt(numGC[m]+(new_area[m]*asymp_den_err)**2)

              rad_profile[4,z] = alog10(rad_profile[2,z])
              rad_profile[5,z] = alog10(rad_profile[2,z] + rad_profile[3,z]) - rad_profile[4,z]
              rad_profile[6,z] = DOUBLE(Number_Formatter(rad_profile[4,z] - alog10(rad_profile[2,z] - rad_profile[3,z]), DECIMAL=5))
              rad_profile[7,z] = DOUBLE(Number_Formatter(bins[5,z], DECIMAL=3))
              rad_profile[8,z] = DOUBLE(Number_Formatter(dist_tmp ^ (0.25), DECIMAL=5))

	      rad_profile[0,z] = DOUBLE(Number_Formatter(rad_profile[0,z], DECIMAL=2))
	      rad_profile[1,z] = DOUBLE(Number_Formatter(rad_profile[1,z], DECIMAL=2))
	      rad_profile[2,z] = DOUBLE(Number_Formatter(rad_profile[2,z], DECIMAL=5))
	      rad_profile[3,z] = DOUBLE(Number_Formatter(rad_profile[3,z], DECIMAL=5))
	      rad_profile[4,z] = DOUBLE(Number_Formatter(rad_profile[4,z], DECIMAL=5))
	      rad_profile[5,z] = DOUBLE(Number_Formatter(rad_profile[5,z], DECIMAL=5))
	      rad_profile[9,z] = DOUBLE(Number_Formatter(rad_profile[9,z], DECIMAL=0))
	      rad_profile[10,z] = DOUBLE(Number_Formatter(rad_profile[10,z], DECIMAL=2))
	      rad_profile[11,z] = DOUBLE(Number_Formatter(rad_profile[11,z], DECIMAL=3))
          endfor
          
          !p.multi = [0,2,2,0,1]

          WIDGET_CONTROL, state.num_gcc, GET_VALUE=n
          WIDGET_CONTROL, state.gcc_table, GET_VALUE=gcc_x, USE_TABLE_SELECT=[1,0,1,n]
          WIDGET_CONTROL, state.gcc_table, GET_VALUE=gcc_y, USE_TABLE_SELECT=[2,0,2,n]
          WIDGET_CONTROL, state.galaxy_x, GET_VALUE=gal_x
          WIDGET_CONTROL, state.galaxy_y, GET_VALUE=gal_y
          gal_x = long(gal_x[0])
          gal_y = long(gal_y[0])
          plot,gcc_x-gal_x,gcc_y-gal_y,psym=symcat(3),TITLE='Spatial Distribution',/ISOTROPIC
	  for z=0,n_bins-1 do begin
	    oplot,/polar,fltarr(500)+bins[0,z],findgen(500)*2*3.14159/500
          endfor

          ploterror,rad_profile[0,*],rad_profile[2,*],rad_profile[3,*],psym=5,TITLE='Radial Profile'
	  safe=WHERE (FINITE(rad_profile[4,*]))
	  devac_rad = rad_profile[8,safe]
	  pow_rad = alog10(rad_profile[0,safe])
	  sd = rad_profile[4,safe]
	  err_bar = rad_profile[5,safe]

	  if(use_additional eq 1) then begin
	    WIDGET_CONTROL, state.add_data_table, GET_VALUE=add_data_points
	    oploterror,add_data_points[0,*],add_data_points[1,*],add_data_points[2,*],psym=6
	    devac_rad_add = add_data_points[0,*] ^ (0.25)
	    pow_rad_add = alog10(add_data_points[0,*])
	    sd_add = alog10(add_data_points[1,*])
	    err_add = alog10(add_data_points[1,*] + add_data_points[2,*]) - sd_add[*]

	    devac_rad = [[rad_profile[8,safe]],[devac_rad_add]]
	    pow_rad = [[alog10(rad_profile[0,safe])],[pow_rad_add]]
	    sd = [[rad_profile[4,safe]],[sd_add]]
	    err_bar = [[rad_profile[5,safe]],[err_add]]

;	    print,devac_rad
;	    print,pow_rad
;	    print,sd
;	    print,err_bar
	  endif

          plot,rad_profile[8,*],rad_profile[4,*],psym=5,TITLE='deVaucouleurs profile',xrange=[0.7,1.5],yrange=[-1.0,2.0]
;	  dev_coeff = poly_fit(rad_profile[8,safe], rad_profile[4,safe], 1, CHISQ=de_chisq, MEASURE_ERRORS=rad_profile[5,safe],SIGMA=dev_sigma,YFIT=dev_calc_y)
	  dev_coeff = poly_fit(devac_rad, sd, 1, CHISQ=de_chisq, MEASURE_ERRORS=err_bar,SIGMA=dev_sigma,YFIT=dev_calc_y)

;          FITEXY, rad_profile[8,safe], rad_profile[4,safe], de_intercept, de_slope, X_SIG=0, Y_SIG=rad_profile[5,safe],de_sigAB,de_chisq
          de_intercept = dev_coeff[0]
	  de_slope = dev_coeff[1]
;	  yfit = de_intercept+de_slope*rad_profile[8,*]

          oploterror,rad_profile[8,*],rad_profile[4,*],rad_profile[5,*],/HIBAR,psym=3
          oploterror,rad_profile[8,*],rad_profile[4,*],rad_profile[6,*],/LOBAR,psym=3
	  if(use_additional eq 1) then begin
	    oploterror,devac_rad_add,sd_add,err_add,psym=6
	  endif

          oplot,devac_rad,dev_calc_y,linestyle=1

          plot,alog10(rad_profile[0,*]),rad_profile[4,*],psym=5,TITLE='Power law profile',xrange=[-0.5,0.8],yrange=[-1.0,2.0]
;	  FITEXY, alog10(rad_profile[0,safe]), rad_profile[4,safe], pow_intercept, pow_slope, X_SIG=0, Y_SIG=rad_profile[5,safe],pow_sigAB,pow_chisq
;          yfit = pow_intercept+pow_slope*alog10(rad_profile[0,*])
;	  pow_coeff = poly_fit(alog10(rad_profile[0,safe]), rad_profile[4,safe], 1, CHISQ=pow_chisq, MEASURE_ERRORS=rad_profile[5,safe],SIGMA=pow_sigma,YFIT=pow_calc_y)
	  pow_coeff = poly_fit(pow_rad, sd, 1, CHISQ=pow_chisq, MEASURE_ERRORS=err_bar,SIGMA=pow_sigma,YFIT=pow_calc_y)
          pow_intercept = pow_coeff[0]
	  pow_slope = pow_coeff[1]
	  oploterror,alog10(rad_profile[0,*]),rad_profile[4,*],rad_profile[5,*],/HIBAR,psym=3
          oploterror,alog10(rad_profile[0,*]),rad_profile[4,*],rad_profile[6,*],/LOBAR,psym=3
	  oplot,pow_rad,pow_calc_y,linestyle=1

	  if(use_additional eq 1) then begin
	    oploterror,pow_rad_add,sd_add,err_add,psym=6
	  endif

	  tmp = size(safe)
	  safe_bins = tmp[1]

          print,'deVaucouleurs Fit:'
	  print,'Intercept: ',de_intercept,' +/-',dev_sigma[0]
	  print,'Slope: ',de_slope,' +/-',dev_sigma[1]
	  print,'ChiSq/DOF: ',de_chisq/(safe_bins - 2)
	  print,''
	  print,'Power Law Fit:'
	  print,'Intercept: ',pow_intercept,' +/-',pow_sigma[0]
	  print,'Slope: ',pow_slope,' +/-',pow_sigma[1]
	  print,'ChiSq/DOF: ',pow_chisq/(safe_bins - 2)
	  print,''

; 	  for n=0,safe_bins-1 do begin
; 	    print,alog10(rad_profile[0,safe[n]]), rad_profile[4,safe[n]],rad_profile[5,safe[n]],pow_calc_y[n]
; 	  endfor
	  
	  openw,1,"radial_profile.dat", WIDTH=1000
	  printf,1,rad_profile
	  close,1

          WIDGET_CONTROL, state.rad_prof_table, SET_VALUE=rad_profile
          WIDGET_CONTROL, state.rad_prof_table, COLUMN_LABELS=labels
          WIDGET_CONTROL, state.rad_prof_table, TABLE_XSIZE=12
          WIDGET_CONTROL, state.rad_prof_table, TABLE_YSIZE=n_bins
          
	  use_devauc = 0

	  de_use = abs(de_chisq/(safe_bins - 2) - 1.0)
	  pow_use = abs(pow_chisq/(safe_bins - 2) - 1.0)
          if (de_use lt pow_use) then begin
              use_devauc = 1
              print,'Integrating using deVaucouleurs...'
	  endif else begin
              use_devauc = 0
	      print,'Integrating using Power law...'
          endelse

	  print,''
	  for z=0,n_bins-1 do begin
	      if ((rad_profile[2,z]-rad_profile[3,z] le 0) and (rad_profile[2,z+1] - rad_profile[3,z+1] le 0)) then begin
		  int_limit = bins[1,z]*.1406/60
		  z = n_bins
	      endif
	  endfor

	  if use_devauc then begin
	    i = 0.00000001
	    int_step = 0.000001
	  endif else begin
	    i = 0.01
	    int_step = 0.000001
	  endelse

	  inner_limit = bins[0,0]*.1406/60

	  if(use_additional eq 1) then begin
	    add_inner_limit = add_data_points[0,0] - (add_data_points[0,1] - add_data_points[0,0])/2.0
	    if(add_inner_limit lt inner_limit) then begin
	      inner_limit = add_inner_limit
	    endif
	  endif

	 
	  inner_total = 0.
          flag = 0
	  tot = 0.
	  step_count = 0
	
          while (i le int_limit) do begin
              if (use_devauc eq 1) then begin
		lsigma = de_intercept + (de_slope*(i^0.25))
              endif else begin
		lsigma = pow_intercept + (pow_slope*alog10(i))
	      endelse
	      
	      sigma = 10.^lsigma
	      tot = tot + (sigma * 2. * 3.14159265359 * i * int_step)

	      if(flag eq 0 and i ge inner_limit) then begin
		  inner_total = tot
		  flag = 1
		  inner_flat_total = (sigma * 3.14159265359 * inner_limit * inner_limit)
		  print,"Interior Values:"
		  print,"Inner Edge 	   Sigma	  Inner Total       Inner Flat Total"
		  print,i,sigma,inner_total,inner_flat_total
	      endif

	      i = i+int_step
	      step_count = step_count + 1.

	      if (step_count eq 100) then begin
;		print,i,sigma,tot, inner_total
		step_count = 0
	      endif

	  endwhile
;	  print,"Int. Limit	   Sigma	Total_N		Inner Total	Inner_Flat Total"
;	  print,i,sigma,tot, inner_total, inner_flat_total

	  WIDGET_CONTROL, state.m_v_tot, GET_VALUE=mvtot_tmp
	  WIDGET_CONTROL, state.dist_mod, GET_VALUE=distmod_tmp
	  WIDGET_CONTROL, state.mlv_ratio, GET_VALUE=mlvratio_tmp

	  tmp1 = tot
          tmp2 = tot - inner_total + inner_flat_total
 
	  tot = (tmp1 + tmp2) / 2.

	  mvtot = double(mvtot_tmp[0])
	  distmod = double(distmod_tmp[0])
	  mlvratio = double(mlvratio_tmp[0])

	  absmvtot = mvtot - distmod
	  temp = 0.4*(absmvtot + 15.)
	  S = tot*(10.^temp)
	  lratio = 10.^((absmvtot - 4.83)/(-2.5))

	  mlratio = mlvratio * lratio
  
	  T = tot / (mlratio/10.^9.)

	  logmass = alog10(mlratio)

	  print,''
	  print,'Final Values:'
	  print,'Edge Sigma = ',sigma
	  print,'Int. Limit = ',i
	  print,'Total N    = ',tot
	  print,'S_N        = ',S
	  print,'T          = ',T
	  print,'log(M)     = ',logmass
	  print,''
; 	  print,tot,S,T,logmass,absmvtot,temp,lratio,mlratio,mvtot,distmod,mlvratio
	   im=tvrd() 
	   write_jpeg,'plots.jpeg',im

        END

     'create_bins': BEGIN
          WIDGET_CONTROL, state.mask_file, GET_VALUE=filename
          FITS_READ, filename, data
	  imsize=size(data)
	  pixel_scale = 0.1406D
	  WIDGET_CONTROL, state.bin_w, GET_VALUE=bin_width
          bin_width = double(bin_width[0])
          bin_width=bin_width*60/pixel_scale
	  WIDGET_CONTROL, state.inner_e, GET_VALUE=inner_edge
          inner_edge = double(inner_edge[0])
          inner_edge=inner_edge*60/pixel_scale
	  WIDGET_CONTROL, state.galaxy_x, GET_VALUE=gal_x
          WIDGET_CONTROL, state.galaxy_y, GET_VALUE=gal_y
	  WIDGET_CONTROL, state.num_bins, GET_VALUE=temp_bins
	  flag=400
	  x_size = imsize[1]
	  y_size = imsize[2]
          gal_x = double(gal_x[0]) - 1.0
          gal_y = double(gal_y[0]) - 1.0
          n_bins = long(temp_bins[0])
	  bin_size=DBLARR(n_bins)
	  bin_area=DBLARR(n_bins)
          bins = DBLARR(7,n_bins)
	  dist = 0.0D

          for z=0,n_bins-1 do begin
            bins[0,z] = bin_width*z+inner_edge
            bins[1,z] = bin_width*(z+1)+inner_edge
          endfor

	    for x=0,x_size-1 do begin
	      for y=0,y_size-1 do begin
		if data[x,y] gt flag then BEGIN
		temp_x = 0.0D + x
		temp_y = 0.0D + y
		dist = ((gal_x-temp_x)^2.) + ((gal_y-temp_y)^2.)
		dist = sqrt(dist)

		for z=0,n_bins-1 do begin
		  if((dist gt bins[0,z]) and (dist le bins[1,z])) then begin
                    bins[2,z] = bins[2,z] + dist
		    bins[3,z] = bins[3,z] + 1.0
		    data[x,y] = z+100
		    z = n_bins
		  endif
		endfor
		endif
	      endfor
	    endfor


	  for j=0,n_bins-1 do begin
            bins[2,j] = bins[2,j]/bins[3,j]
	    bins[4,j] = bins[1,j]^2. * 3.14159265359D - bins[0,j]^2. * 3.14159265359D
            bins[5,j] = bins[3,j]/bins[4,j]
	  endfor

            labels = ['Inner Edge', 'Outer Edge', 'Avg Distance', 'Unmasked Area', 'Total Bin Area', 'Unmasked Fraction', 'N (gcc)']
            WIDGET_CONTROL, state.bins_table, SET_VALUE=bins
            WIDGET_CONTROL, state.bins_table, COLUMN_LABELS=labels
            WIDGET_CONTROL, state.bins_table, TABLE_YSIZE=n_bins
            WIDGET_CONTROL, state.bins_table, TABLE_XSIZE=7

          openw,1,"temp_bin_file.dat"
          printf,1,bins
          close,1

	  FITS_WRITE,"miketestimage.fits",data
      END
    
    'save_gal_data' : BEGIN

	 WIDGET_CONTROL, state.galaxy_x, GET_VALUE=gal_x
	 WIDGET_CONTROL, state.galaxy_y, GET_VALUE=gal_y
	 WIDGET_CONTROL, state.num_gcc, GET_VALUE=n_gcc
	 WIDGET_CONTROL, state.bin_w, GET_VALUE=binw
	 WIDGET_CONTROL, state.inner_e, GET_VALUE=innere
	 WIDGET_CONTROL, state.num_bins, GET_VALUE=nbins
	 WIDGET_CONTROL, state.contam, GET_VALUE=con
	 WIDGET_CONTROL, state.gclf_cover, GET_VALUE=gclfcover
	 WIDGET_CONTROL, state.mlv_ratio, GET_VALUE=mlvratio
	 WIDGET_CONTROL, state.m_v_tot, GET_VALUE=mvtot
	 WIDGET_CONTROL, state.dist_mod, GET_VALUE=distmod

	 openw,1,"galaxy.dat"
	 printf,1,gal_x
	 printf,1,gal_y
         printf,1,n_gcc
	 printf,1,binw
	 printf,1,innere
         printf,1,nbins
	 printf,1,con
	 printf,1,gclfcover
	 printf,1,mlvratio
	 printf,1,mvtot
	 printf,1,distmod
	 close,1
      END

    'load_gal_data' : BEGIN
	 openr,1,"galaxy.dat"
	 tmp = ''
	 
	 readf,1,tmp
	 WIDGET_CONTROL, state.galaxy_x, SET_VALUE=tmp
	 readf,1,tmp
	 WIDGET_CONTROL, state.galaxy_y, SET_VALUE=tmp
	 readf,1,tmp
	 WIDGET_CONTROL, state.num_gcc, SET_VALUE=tmp
	 readf,1,tmp
	 WIDGET_CONTROL, state.bin_w, SET_VALUE=tmp
	 readf,1,tmp
	 WIDGET_CONTROL, state.inner_e, SET_VALUE=tmp
	 readf,1,tmp
	 WIDGET_CONTROL, state.num_bins, SET_VALUE=tmp
	 readf,1,tmp
	 WIDGET_CONTROL, state.contam, SET_VALUE=tmp
	 readf,1,tmp
	 WIDGET_CONTROL, state.gclf_cover, SET_VALUE=tmp
	 readf,1,tmp
	 WIDGET_CONTROL, state.mlv_ratio, SET_VALUE=tmp
	 readf,1,tmp
	 WIDGET_CONTROL, state.m_v_tot, SET_VALUE=tmp
	 readf,1,tmp
	 WIDGET_CONTROL, state.dist_mod, SET_VALUE=tmp
	 close,1
      END

  ENDCASE  
END  


PRO galaxy_analysis
COMMON global, use_additional
base = WIDGET_BASE(/COLUMN, /BASE_ALIGN_TOP)
base_row1 = WIDGET_BASE(base, /ROW)
button_base = WIDGET_BASE(base_row1, /COLUMN)
values_base = WIDGET_BASE(base_row1, /COLUMN)
base_column1 = WIDGET_BASE(base_row1, /COLUMN)  
base_col1_row1 = WIDGET_BASE(base_column1, /ROW)
base_col1_row2 = WIDGET_BASE(base_column1, /ROW)
data_base = WIDGET_BASE(base_col1_row1, /COLUMN)
bins_base = WIDGET_BASE(base_col1_row1, /COLUMN)
rad_prof_base = WIDGET_BASE(base_col1_row2, /COLUMN)

load_gcc = WIDGET_BUTTON(button_base, VALUE='Load GCC Data', UVALUE='load_gcc')
plot_gcc = WIDGET_BUTTON(button_base, VALUE='Plot GCC Data', UVALUE='plot_gcc')
load_fits = WIDGET_BUTTON(button_base, VALUE='Load Masked FITS', UVALUE='load_fits')
create_bins = WIDGET_BUTTON(button_base, VALUE='Create radial bins', UVALUE='create_bins')
load_bins = WIDGET_BUTTON(button_base, VALUE='Load bins from file', UVALUE='load_bins')
save_gal_data = WIDGET_BUTTON(button_base, VALUE='Save Galaxy Data', UVALUE='save_gal_data')
load_gal_data = WIDGET_BUTTON(button_base, VALUE='Load Galaxy Data', UVALUE='load_gal_data')
load_add_data = WIDGET_BUTTON(button_base, VALUE='Load Additional Data', UVALUE='load_add_data')
bin_gccs = WIDGET_BUTTON(button_base, VALUE='Bin GCCs and Integrate', UVALUE='bin_gccs')
quit = WIDGET_BUTTON(button_base, VALUE='QUIT', UVALUE='quit')
mask_label = WIDGET_LABEL(button_base, VALUE='MASKED FITS FILE', UVALUE='masked_label1')
mask_file = WIDGET_LABEL(button_base, VALUE='No file loaded', UVALUE='mask_file')
data_label = WIDGET_LABEL(button_base, VALUE='GCC DATA', UVALUE='gcc_datalabel1')
gcc_data_label = WIDGET_LABEL(button_base, VALUE='No file loaded', UVALUE='gcc_data_label')


text_label1 = WIDGET_LABEL(values_base, VALUE='Number of GCCs', UVALUE='GCC_Label')
num_gcc = WIDGET_TEXT(values_base, VALUE='0', UVALUE='num_gcc')
text_label2 = WIDGET_LABEL(values_base, VALUE='Galaxy X', UVALUE='galx_Label')
galaxy_x = WIDGET_TEXT(values_base, /EDITABLE, VALUE='0', UVALUE='galaxy_y')
text_label3 =  WIDGET_LABEL(values_base, VALUE='Galaxy Y', UVALUE='galy_Label')
galaxy_y = WIDGET_TEXT(values_base, /EDITABLE, VALUE='0', UVALUE='galaxy_x')
text_label4 = WIDGET_LABEL(values_base, VALUE='Bin Width (arcmin)', UVALUE='bin_w_label')
bin_w = WIDGET_TEXT(values_base, /EDITABLE, VALUE='0.5', UVALUE='bin_w')
text_label5 = WIDGET_LABEL(values_base, VALUE='Inner Edge (arcmin)', UVALUE='inner_e_label')
inner_e = WIDGET_TEXT(values_base, /EDITABLE, VALUE='0.15', UVALUE='inner_e')
text_label6 = WIDGET_LABEL(values_base, VALUE='Number of Bins', UVALUE='num_bins_label')
num_bins = WIDGET_TEXT(values_base, /EDITABLE, VALUE='10', UVALUE='num_bins')
text_label7 =WIDGET_LABEL(values_base, VALUE='Contamination', UVALUE='contam_label')
contam = WIDGET_TEXT(values_base, /EDITABLE, VALUE='1.0', UVALUE='contam')
text_label7a =WIDGET_LABEL(values_base, VALUE='Contamination Error', UVALUE='contam_error_label')
contam_err = WIDGET_TEXT(values_base, /EDITABLE, VALUE='0.1', UVALUE='contam_err')
text_label8 = WIDGET_LABEL(values_base, VALUE='GCLF Coverage', UVALUE='gclf_cover_label')
gclf_cover = WIDGET_TEXT(values_base, /EDITABLE, VALUE='0.8', UVALUE='gclf_cover')
text_label9 = WIDGET_LABEL(values_base, VALUE='M/L_V Ratio', UVALUE='mlv_ratio_label')
mlv_ratio = WIDGET_TEXT(values_base, /EDITABLE, VALUE='10.0', UVALUE='mlv_ratio')
text_label10 = WIDGET_LABEL(values_base, VALUE='M_V Total', UVALUE='m_v_total_label')
m_v_tot = WIDGET_TEXT(values_base, /EDITABLE, VALUE='11.0', UVALUE='m_v_tot')
text_label11 = WIDGET_LABEL(values_base, VALUE='Distance Modulus', UVALUE='dist_mod_label')
dist_mod = WIDGET_TEXT(values_base, /EDITABLE, VALUE='30.0', UVALUE='dist_mod')

gcc_table_label = WIDGET_LABEL(data_base, VALUE='GCCs', UVALUE='gcc_table_label')
gcc_table = WIDGET_TABLE(data_base, UVALUE='gcc_table')

bins_label = WIDGET_LABEL(bins_base, VALUE='RADIAL BINS', UVALUE='bins_label1')
bins_table = WIDGET_TABLE(bins_base, UVALUE='bins_table')

rad_prof_label = WIDGET_LABEL(rad_prof_base, VALUE='RADIAL PROFILE', UVALUE='rad_prof_label1')
rad_prof_table = WIDGET_TABLE(rad_prof_base, UVALUE='rad_prof_table', XSIZE=12)

add_data_label = WIDGET_LABEL(rad_prof_base, VALUE='Additional Points To Fit', UVALUE='add_data_label1')
add_data_table = WIDGET_TABLE(rad_prof_base, UVALUE='add_data_table', XSIZE=3)

state = {load_add_data:load_add_data, add_data_table:add_data_table, contam_err:contam_err, load_gcc:load_gcc, plot_gcc:plot_gcc, gcc_table:gcc_table, num_gcc:num_gcc, gcc_data_label:gcc_data_label, load_fits:load_fits, create_bins:create_bins, mask_file:mask_file, quit:quit, galaxy_x:galaxy_x, galaxy_y:galaxy_y, bin_w:bin_w, inner_e:inner_e, num_bins:num_bins, bins_table:bins_table, bin_gccs:bin_gccs, rad_prof_table:rad_prof_table, contam:contam, gclf_cover:gclf_cover, load_bins:load_bins, mlv_ratio:mlv_ratio, m_v_tot:m_v_tot, dist_mod:dist_mod, save_gal_data:save_gal_data, load_gal_data:load_gal_data}
 
widget_control, base, set_uvalue=state, /realize                                
xmanager, 'galaxy_analysis', base, /no_block 

END