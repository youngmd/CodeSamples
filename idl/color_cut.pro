PRO color_cut_event, ev  
  WIDGET_CONTROL, ev.TOP, GET_UVALUE=stash
  WIDGET_CONTROL, ev.ID, GET_UVALUE=uval 

    CASE uval OF  

      'add_gcc'  : BEGIN
	     WIDGET_CONTROL, stash.num_cut, GET_VALUE=z_tmp
	     z = long(z_tmp[0]) - 1
	     WIDGET_CONTROL, stash.gcc_table, GET_VALUE=add_row, /USE_TABLE_SELECT
	     WIDGET_CONTROL, stash.cut_table, INSERT_ROWS=1
	     WIDGET_CONTROL, stash.cut_table, SET_VALUE=add_row, USE_TABLE_SELECT=[0,z+1,18,z+1]
	     WIDGET_CONTROL, stash.num_cut, SET_VALUE=STRING(z+2)
	     WIDGET_CONTROL, stash.add_gcc, SENSITIVE=0
	     WIDGET_CONTROL, stash.remove_gcc, SENSITIVE=1
	     WIDGET_CONTROL, stash.cut_table, SET_TABLE_SELECT=[0,z+1,18,z+1]
	    END

      'remove_gcc': BEGIN
	     WIDGET_CONTROL, stash.num_cut, GET_VALUE=z_tmp
	     z = long(z_tmp[0])
	     WIDGET_CONTROL, stash.cut_table, /DELETE_ROWS
	     WIDGET_CONTROL, stash.num_cut, SET_VALUE=STRING(z-1)
	     WIDGET_CONTROL, stash.add_gcc, SENSITIVE=1
	     WIDGET_CONTROL, stash.remove_gcc, SENSITIVE=0
	    END
	
      'save_gcc': BEGIN
	      WIDGET_CONTROL, stash.cut_table, GET_VALUE=gccs
	      gcc_file=Dialog_Pickfile(Filter='*.*', /Write)
	      openw,1,gcc_file
	      printf,1,'# name/id	bx	by	am_b	b_i	err	vx	vy	am_v	v_i	err	rx	ry	am_r	r_i	err	V	B-V	V-R  '
	      printf,1,'#############################################################################################################################################################'
	      printf,1,gccs,FORMAT='(I4,1X,F7.2,1X,F7.2,1X,F7.5,1X,F8.5,1X,F8.5,1X,F7.2,1X,F7.2,1X,F7.5,1X,F8.5,1X,F8.5,1X,F7.2,1X,F7.2,1X,F7.5,1X,F8.5,1X,F8.5,1X,F6.3,1X,F5.3,1X,F5.3)'
	      close,1
	    END

      'load_gcc' : BEGIN
	    junk = ' '
	    gcc_file=Dialog_Pickfile(Filter='*.*', /Read)
	    WIDGET_CONTROL, stash.gcc_table_label, SET_VALUE=gcc_file
	    openr,1,gcc_file
	    gcc_data=FLTARR(19,10000) ;A big array to hold the data 
	    S=FLTARR(19,1)      ;A small array to read a line 
	    readf,1,junk
	    readf,1,junk
	    ON_IOERROR,ers     ;Jump to statement ers when I/O error is detected 
	    n=0 ; Create a counter 
	    WHILE n LT 10000 DO BEGIN 
		READF,1,S    ;Read a line of data 
		PRINT,S      ;Print the line 
		gcc_data[*,n]=S     ;Store it in H 
		n=n+1        ;Increment the counter 
	    ENDWHILE          ;End of while loop 
	    ers: CLOSE,1         ;Jump to this statement when an end of file is detected   
	    gcc_data=gcc_data[*,0:n-1]  
	    WIDGET_CONTROL, stash.gcc_table, SET_VALUE=gcc_data
	    WIDGET_CONTROL, stash.gcc_table, TABLE_XSIZE=19
	    WIDGET_CONTROL, stash.gcc_table, TABLE_YSIZE=n
	    WIDGET_CONTROL, stash.num_gcc, SET_VALUE=STRING(n)
	    labels =['name/id','bx','by','am_b','b_i','err','vx','vy','am_v','v_i','err','rx','ry','am_r','r_i','err','V','B-V','V-R']
	    WIDGET_CONTROL, stash.gcc_table, COLUMN_LABELS=labels

	  END
      
      'plot_gcc' : BEGIN

	    WIDGET_CONTROL, stash.num_gcc, GET_VALUE=n
	    n = n - 1
	    WIDGET_CONTROL, stash.gcc_table, GET_VALUE=gcc_bmv, USE_TABLE_SELECT=[17,0,17,n]
	    WIDGET_CONTROL, stash.gcc_table, GET_VALUE=gcc_vmr, USE_TABLE_SELECT=[18,0,18,n]
	    WIDGET_CONTROL, stash.gcc_table, GET_VALUE=gcc_xy, USE_TABLE_SELECT=[1,0,2,n]

	    ;print,gcc_xy

	    WIDGET_CONTROL, stash.draw2, GET_VALUE=drawID
	    WSET, drawID
	    plot,gcc_xy[0,*],gcc_xy[1,*],psym=3

	    WIDGET_CONTROL, stash.draw, GET_VALUE=drawID
	    WSET, drawID
	    plot,gcc_bmv,gcc_vmr,psym=3

	  END

      'cut_gcc' : BEGIN
	    photom_file=Dialog_Pickfile(Filter='*.*', /Read)
	    openr,1,photom_file
	    readf,1,zp_v
	    readf,1,zp_v_err
	    readf,1,zp_bv
	    readf,1,zp_bv_err
	    readf,1,zp_vr
	    readf,1,zp_vr_err
	    readf,1,eps_bv
	    readf,1,eps_bv_err
	    readf,1,mu_bv
	    readf,1,mu_bv_err
	    readf,1,mu_vr
	    readf,1,mu_vr_err
	    close,1

	    WIDGET_CONTROL, stash.num_gcc, GET_VALUE=n_tmp
	    n = long(n_tmp[0]) - 1
	    WIDGET_CONTROL, stash.gcc_table, GET_VALUE=gcc_bmv, USE_TABLE_SELECT=[17,0,17,n]
	    WIDGET_CONTROL, stash.gcc_table, GET_VALUE=gcc_vmr, USE_TABLE_SELECT=[18,0,18,n]
	    WIDGET_CONTROL, stash.gcc_table, GET_VALUE=gcc_berr, USE_TABLE_SELECT=[5,0,5,n]
	    WIDGET_CONTROL, stash.gcc_table, GET_VALUE=gcc_verr, USE_TABLE_SELECT=[10,0,10,n]
	    WIDGET_CONTROL, stash.gcc_table, GET_VALUE=gcc_rerr, USE_TABLE_SELECT=[15,0,15,n]

	    WIDGET_CONTROL, stash.draw, GET_VALUE=drawID
	    WSET, drawID
	    plot,gcc_bmv,gcc_vmr,psym=3
	    
	    cut = FLTARR(19,n+1)
	    count = 0
	    theta = atan(0.4213558)
	    FOR z=0,n do BEGIN
	    
	      pass = 0

	      berr = gcc_berr[z]
	      verr = gcc_verr[z]
	      rerr = gcc_rerr[z]
	      bmv = gcc_bmv[z]
	      vmr = gcc_vmr[z]

	      bmverr = ((mu_bv_err^2.)/(mu_bv^2.)) + ((berr^2. + verr^2.)/((bmv)^2.)) 
	      bmverr = bmverr * ((mu_bv*(bmv))^2.)
	      bmverr = bmverr + zp_bv_err^2.
	      bmverr = sqrt(bmverr)
	      vmrerr = ((mu_vr_err^2.)/(mu_vr^2.)) + ((verr^2. + rerr^2.)/((vmr)^2.))
	      vmrerr = vmrerr * ((mu_vr*(vmr))^2.)
	      vmrerr = vmrerr + zp_vr_err^2.
	      vmrerr = sqrt(vmrerr)
; 	      bmvphoterr = sqrt(berr^2 + verr^2)
; 	      vmrphoterr = sqrt(verr^2 + rerr^2)
; 	      bmverr = sqrt((bmvphoterr)^2. + (0.081298^2.))
; 	      vmrerr = sqrt((vmrphoterr)^2. + (0.031677^2.)) 
	      vmr_expected = 0.1703432 + (0.4213558*bmv)
	      delta_vmr = vmr_expected - vmr
	      dvmr = delta_vmr * cos(theta)
	      dbmv = delta_vmr * sin(theta)
	      vmrerr = vmrerr * cos(theta)
	      bmverr = bmverr / cos(theta)
	      if (dvmr lt 0.) then begin
		  dvmr = -dvmr
		  above=1
	      endif else begin 
		above = 0 
	      endelse
	      if (dvmr le (vmrerr+(3.*0.03))) then begin
		pass = 1
	      endif

	      print,dvmr,(vmrerr+(3.*0.03)),bmverr,bmv,vmr,pass

	      if (pass eq 1) then begin

		lbmv = bmv + (dvmr*sin(theta)) 
		sbmv = bmv - (dvmr*sin(theta)) 

		if (above eq 0) then begin
		  if ((sbmv gt (0.55536083-bmverr))&&(sbmv lt (0.9920817+bmverr))) then begin
		    WIDGET_CONTROL, stash.gcc_table, GET_VALUE=cut_row, USE_TABLE_SELECT=[0,z,18,z]
		    cut[*,count] = cut_row[*]
		    count++
		    pass = 0
		  endif 
		endif else begin
		    if ((lbmv gt (0.55536083-bmverr))&&(lbmv lt (0.9920817+bmverr)))then begin
		      WIDGET_CONTROL, stash.gcc_table, GET_VALUE=cut_row, USE_TABLE_SELECT=[0,z,18,z]
		      cut[*,count] = cut_row[*]
		      print,count
		      count++
		      pass = 0
		    endif
		endelse   

		pass = 0

	     endif
	  endfor  
	  cut = cut[*,0:count-1]
	  WIDGET_CONTROL, stash.num_cut, SET_VALUE=STRING(count)
	  WIDGET_CONTROL, stash.cut_table, SET_VALUE=cut
	  WIDGET_CONTROL, stash.cut_table, TABLE_XSIZE=19
	  WIDGET_CONTROL, stash.cut_table, TABLE_YSIZE=count
	  WIDGET_CONTROL, stash.gcc_table, GET_VALUE=gcc_xy, USE_TABLE_SELECT=[1,0,2,n]
	  WIDGET_CONTROL, stash.draw2, GET_VALUE=drawID
	  WSET, drawID
	  plot,gcc_xy[0,*],gcc_xy[1,*],psym=3
	  oplot,cut[1,*],cut[2,*],psym=4

	  WIDGET_CONTROL, stash.draw, GET_VALUE=drawID
	  WSET, drawID
	  plot,gcc_bmv,gcc_vmr,psym=3
	  oplot,cut[17,*],cut[18,*],psym=4

          ;WIDGET_CONTROL, stash.cut_table, COLUMN_LABELS=labels
	END

      'draw1' : BEGIN
	    IF (ev.release eq 1) THEN BEGIN
	      WIDGET_CONTROL, stash.draw, GET_VALUE=drawID
	      WIDGET_CONTROL, stash.draw2, GET_VALUE=drawID2
	      redraw1,drawID,stash.gcc_table,stash.cut_table,stash.num_gcc,stash.num_cut ;replot to reset reference frame
	      pointing = CONVERT_COORD(ev.X,ev.Y,/DEVICE,/TO_DATA)

	      WIDGET_CONTROL, stash.num_gcc, GET_VALUE=n_tmp
	      n = long(n_tmp[0]) - 1
	      tmp_gcc_array = FLTARR(4,n+1)
	      WIDGET_CONTROL, stash.gcc_table, GET_VALUE=gcc_bmv, USE_TABLE_SELECT=[17,0,17,n]
	      WIDGET_CONTROL, stash.gcc_table, GET_VALUE=gcc_vmr, USE_TABLE_SELECT=[18,0,18,n]
	      WIDGET_CONTROL, stash.gcc_table, GET_VALUE=id, USE_TABLE_SELECT=[0,0,0,n]

	      tmp_gcc_array[0,*] = id[*]
	      tmp_gcc_array[1,*] = gcc_bmv[*]
	      tmp_gcc_array[2,*] = gcc_vmr[*]

	      FOR z=0,n do BEGIN
		tmp_gcc_array[3,z] = sqrt((tmp_gcc_array[1,z]-pointing[0])^2. + (tmp_gcc_array[2,z]-pointing[1])^2.)
	      ENDFOR
	      
	      tmp_sort = SORT(tmp_gcc_array[3,*])
	      ;print,tmp_gcc_array[*,tmp_sort]

	      selected = long(tmp_gcc_array[0,tmp_sort[0]] - 1)
	      ;help,selected

	      WIDGET_CONTROL, stash.gcc_table, SET_TABLE_SELECT=[0,selected,18,selected]

	      WIDGET_CONTROL, stash.gcc_table, GET_VALUE=selected_color, USE_TABLE_SELECT=[17,selected,18,selected]
	      
	      tmp_array2 = FLTARR(2,1)
	      tmp_array2[0,0] = selected_color[0]
	      tmp_array2[1,0] = selected_color[1]
	      plots,tmp_array2[0,0],tmp_array2[1,0],psym=symcat(35),symsize=2

	      WIDGET_CONTROL, stash.gcc_table, GET_VALUE=selected_xy, USE_TABLE_SELECT=[1,selected,2,selected]

	      tmp_array1 = FLTARR(2,1)
	      tmp_array1[0,0] = selected_xy[0]
	      tmp_array1[1,0] = selected_xy[1]
	      
	      redraw2,drawID2,stash.gcc_table,stash.cut_table,stash.num_gcc,stash.num_cut
	      plots,tmp_array1[0,0],tmp_array1[1,0],psym=symcat(35),symsize=2

	      WIDGET_CONTROL, stash.gcc_table, GET_VALUE=selected_id, USE_TABLE_SELECT=[0,selected,0,selected]
	      WIDGET_CONTROL, stash.num_cut, GET_VALUE=z_tmp
	      z = long(z_tmp[0]) - 1
	      WIDGET_CONTROL, stash.cut_table, GET_VALUE=cut_ids, USE_TABLE_SELECT=[0,0,0,z]
	      match = 0
	      for j=0,z do begin
		;print,(cut_ids[j] - selected_id)
		if(cut_ids[j] - selected_id eq 0.0) then begin
		  WIDGET_CONTROL, stash.add_gcc, SENSITIVE=0
		  WIDGET_CONTROL, stash.remove_gcc, SENSITIVE=1
		  WIDGET_CONTROL, stash.cut_table, SET_TABLE_SELECT=[0,j,18,j]
		  match = 1
		endif
	      endfor

	      if(match eq 0) then begin
		WIDGET_CONTROL, stash.add_gcc, SENSITIVE=1
		WIDGET_CONTROL, stash.remove_gcc, SENSITIVE=0
	      endif
	      

	    ENDIF
	  END

      'draw2' : BEGIN
	    IF (ev.release eq 1) THEN BEGIN

	      WIDGET_CONTROL, stash.draw2, GET_VALUE=drawID2
	      WIDGET_CONTROL, stash.draw, GET_VALUE=drawID
	      redraw2,drawID2,stash.gcc_table,stash.cut_table,stash.num_gcc,stash.num_cut ;replot to put us in right reference frame

	      pointing = CONVERT_COORD(ev.X,ev.Y,/DEVICE,/TO_DATA)

	      WIDGET_CONTROL, stash.num_gcc, GET_VALUE=n_tmp
	      n = long(n_tmp[0]) - 1
	      tmp_gcc_array = FLTARR(4,n+1)
	      WIDGET_CONTROL, stash.gcc_table, GET_VALUE=gcc_x, USE_TABLE_SELECT=[1,0,1,n]
	      WIDGET_CONTROL, stash.gcc_table, GET_VALUE=gcc_y, USE_TABLE_SELECT=[2,0,2,n]
	      WIDGET_CONTROL, stash.gcc_table, GET_VALUE=gcc_bmv, USE_TABLE_SELECT=[17,0,17,n]
	      WIDGET_CONTROL, stash.gcc_table, GET_VALUE=gcc_vmr, USE_TABLE_SELECT=[18,0,18,n]
	      WIDGET_CONTROL, stash.gcc_table, GET_VALUE=id, USE_TABLE_SELECT=[0,0,0,n]

	      tmp_gcc_array[0,*] = id[*]
	      tmp_gcc_array[1,*] = gcc_x[*]
	      tmp_gcc_array[2,*] = gcc_y[*]

	      FOR z=0,n do BEGIN
		tmp_gcc_array[3,z] = sqrt((tmp_gcc_array[1,z]-pointing[0])^2. + (tmp_gcc_array[2,z]-pointing[1])^2.)
	      ENDFOR
	      
	      tmp_sort = SORT(tmp_gcc_array[3,*])
	      ;print,tmp_gcc_array[*,tmp_sort]

	      selected = long(tmp_gcc_array[0,tmp_sort[0]] - 1)
	      WIDGET_CONTROL, stash.gcc_table, SET_TABLE_SELECT=[0,selected,18,selected]
	      WIDGET_CONTROl, stash.gcc_table, GET_VALUE=selected_color, USE_TABLE_SELECT=[17,selected,18,selected]
	      WIDGET_CONTROL, stash.gcc_table, GET_VALUE=selected_xy, USE_TABLE_SELECT=[1,selected,2,selected]

	      tmp_array1 = FLTARR(2,1)
	      tmp_array1[0,0] = selected_xy[0]
	      tmp_array1[1,0] = selected_xy[1]
	      
	      redraw2,drawID2,stash.gcc_table,stash.cut_table,stash.num_gcc,stash.num_cut
	      plots,tmp_array1[0,0],tmp_array1[1,0],psym=symcat(35),symsize=2

	      tmp_array2 = FLTARR(2,1)
	      tmp_array2[0,0] = selected_color[0]
	      tmp_array2[1,0] = selected_color[1]
	      redraw1,drawID,stash.gcc_table,stash.cut_table,stash.num_gcc,stash.num_cut
	      plots,tmp_array2[0,0],tmp_array2[1,0],psym=symcat(35),symsize=2
	      
	      WIDGET_CONTROL, stash.gcc_table, GET_VALUE=selected_id, USE_TABLE_SELECT=[0,selected,0,selected]
	      WIDGET_CONTROL, stash.num_cut, GET_VALUE=z_tmp
	      z = long(z_tmp[0]) - 1
	      WIDGET_CONTROL, stash.cut_table, GET_VALUE=cut_ids, USE_TABLE_SELECT=[0,0,0,z]
	      match = 0
	      for j=0,z do begin
		;print,(cut_ids[j] - selected_id)
		if(cut_ids[j] - selected_id eq 0.0) then begin
		  WIDGET_CONTROL, stash.add_gcc, SENSITIVE=0
		  WIDGET_CONTROL, stash.remove_gcc, SENSITIVE=1
		  WIDGET_CONTROL, stash.cut_table, SET_TABLE_SELECT=[0,j,18,j]
		  match = 1
		endif
	      endfor

	      if(match eq 0) then begin
		WIDGET_CONTROL, stash.add_gcc, SENSITIVE=1
		WIDGET_CONTROL, stash.remove_gcc, SENSITIVE=0
	      endif

	    ENDIF

	  END
    END

END

pro redraw1,drawID,gcc_table_id,cut_table_id,num_gcc_id,cut_gcc_id
  WSET, drawID
  WIDGET_CONTROL, num_gcc_id, GET_VALUE=n_tmp
  n = long(n_tmp[0]) - 1
  WIDGET_CONTROL, gcc_table_id, GET_VALUE=gcc_bmv, USE_TABLE_SELECT=[17,0,17,n]
  WIDGET_CONTROL, gcc_table_id, GET_VALUE=gcc_vmr, USE_TABLE_SELECT=[18,0,18,n]
  plot,gcc_bmv,gcc_vmr,psym=3,xrange=[0,1.5],yrange=[0,0.8]
  WIDGET_CONTROL, cut_gcc_id, GET_VALUE=z_tmp
  z = long(z_tmp[0]) - 1
  WIDGET_CONTROL, cut_table_id, GET_VALUE=cut_bmv, USE_TABLE_SELECT=[17,0,17,z]
  WIDGET_CONTROL, cut_table_id, GET_VALUE=cut_vmr, USE_TABLE_SELECT=[18,0,18,z]
  oplot,cut_bmv,cut_vmr,psym=4
  x = [0.5121,0.9521,1.028,0.5879,0.5121]
  y = [0.4998,0.6852,0.4898,0.3044,0.4998]
  plots,x,y
  return
END

pro redraw2,drawID,gcc_table_id,cut_table_id,num_gcc_id,cut_gcc_id
  WSET, drawID
  WIDGET_CONTROL, num_gcc_id, GET_VALUE=n_tmp
  n = long(n_tmp[0]) - 1
  WIDGET_CONTROL, gcc_table_id, GET_VALUE=gcc_bmv, USE_TABLE_SELECT=[1,0,1,n]
  WIDGET_CONTROL, gcc_table_id, GET_VALUE=gcc_vmr, USE_TABLE_SELECT=[2,0,2,n]
  plot,gcc_bmv,gcc_vmr,psym=3
  WIDGET_CONTROL, cut_gcc_id, GET_VALUE=z_tmp
  z = long(z_tmp[0]) - 1
  WIDGET_CONTROL, cut_table_id, GET_VALUE=cut_bmv, USE_TABLE_SELECT=[1,0,1,z]
  WIDGET_CONTROL, cut_table_id, GET_VALUE=cut_vmr, USE_TABLE_SELECT=[2,0,2,z]
  oplot,cut_bmv,cut_vmr,psym=4
  return
END

PRO color_cut
  loadct,5
  base = WIDGET_BASE(/COLUMN)
  base_row1 = WIDGET_BASE(base, /ROW)
  button_base = WIDGET_BASE(base_row1, /COLUMN)
  graphic_base = WIDGET_BASE(base_row1, /ROW)
  base_row2 = WIDGET_BASE(base, /ROW)
  data_base = WIDGET_BASE(base_row2, /COLUMN)

  load_gcc = WIDGET_BUTTON(button_base, VALUE='Load Calibrated Data', UVALUE='load_gcc')
  plot_gcc = WIDGET_BUTTON(button_base, VALUE='Plot Calibrated Colors', UVALUE='plot_gcc')
  cut_gcc = WIDGET_BUTTON(button_base, VALUE='Perform Color Cut', UVALUE='cut_gcc')
  gcc_label = WIDGET_LABEL(button_base, VALUE='Point Sources', UVALUE='gcc_label')
  num_gcc = WIDGET_TEXT(button_base, VALUE='0', UVALUE='num_gcc')
  cut_label = WIDGET_LABEL(button_base, VALUE='GCCs', UVALUE='cut_label')
  num_cut = WIDGET_TEXT(button_base, VALUE='0', UVALUE='num_cut')
  add_gcc = WIDGET_BUTTON(button_base, VALUE='Add', UVALUE='add_gcc', SENSITIVE=0)
  remove_gcc = WIDGET_BUTTON(button_base, VALUE='Remove', UVALUE='remove_gcc', SENSITIVE=0)
  save_gcc = WIDGET_BUTTON(button_base, VALUE='Save Color Cut', UVALUE='save_gcc')
  draw = WIDGET_DRAW(graphic_base, XSIZE=500, YSIZE=500, /BUTTON_EVENTS, UVALUE='draw1')
  draw2 = WIDGET_DRAW(graphic_base, XSIZE=500, YSIZE=500, /BUTTON_EVENTS, UVALUE='draw2')

  gcc_table_label = WIDGET_LABEL(data_base, VALUE='Sources', UVALUE='gcc_table_label', /DYNAMIC_RESIZE)
  gcc_table = WIDGET_TABLE(data_base, X_SCROLL_SIZE=15, UVALUE='gcc_table')
  
  cut_table_label = WIDGET_LABEL(data_base, VALUE='GCCs', UVALUE='cut_table_label', /DYNAMIC_RESIZE)
  cut_table = WIDGET_TABLE(data_base, X_SCROLL_SIZE=15, UVALUE='cut_table')

  WIDGET_CONTROL, base, /REALIZE
  WIDGET_CONTROL, draw, GET_VALUE = drawID1
  WIDGET_CONTROL, draw2, GET_VALUE = drawID2
  print,drawID1,drawID2

  ; Create an anonymous array to hold the image data and widget IDs
  ; of the label widgets.
  stash = {save_gcc:save_gcc, add_gcc:add_gcc, remove_gcc:remove_gcc, cut_table:cut_table, cut_gcc:cut_gcc, draw:draw, draw2:draw2, gcc_table:gcc_table, load_gcc:load_gcc, gcc_table_label:gcc_table_label, plot_gcc:plot_gcc, num_gcc:num_gcc, num_cut:num_cut}

  ; Set the user value of the top-level base widget equal to the
  ; 'stash' array.
  WIDGET_CONTROL, base, SET_UVALUE=stash



  xmanager, 'color_cut', base, /no_block 

END
