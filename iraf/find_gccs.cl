#
#find_gccs.cl
#
#Required files:
#	V.fits
#	I.fits
#	remove_duplicates
#	galaxy.imsets
#
#DAOFIND
########
apphot.daofind V.fits[1] output="V.coo" verify=no datapars.fwhmpsf=1.75  datapars.sigma=0.01106 findpars.threshold=1.5
apphot.daofind I.fits[1] output="I.coo" verify=no datapars.fwhmpsf=1.8  datapars.sigma=0.01368 findpars.threshold=1.5
#
#FIRST PHOT
###########
unlearn phot
unlearn datapars
unlearn photpars
unlearn centerpars
unlearn fitskypars
#
phot.interactive=no
phot.verify=no
# the gain is set to 
datapars.gain="exptime"
datapars.readnoise=0.0
datapars.filter="filtnam1"
datapars.obstime="time-obs"
datapars.sigma=INDEF
centerpars.cbox=10
centerpars.maxshift=10.
fitskypars.salgorithm="median"
fitskypars.dannulus=3.
# coords come from imexam so there is no need to recenter
centerpars.calgorithm="centroid"
#
phot image="V.fits[1]" coords="V.coo" datapars.fwhmpsf=1.75 photpars.apertures="0.5,3.0" fitskypars.annulus=5.0 output="V.mag.1"
#
phot image="I.fits[1]" coords="I.coo" datapars.fwhmpsf=1.80 photpars.apertures="0.5,3.0" fitskypars.annulus=5.0 output="I.mag.1"
#
#TXDUMP
#######
txdump V.mag.1 fields="xcen,ycen,stdev,flux" expr=yes > V.txdump
txdump I.mag.1 fields="xcen,ycen,stdev,flux" expr=yes > I.txdump
#
#CUT DUPLICATES
###############
!awk -f remove_duplicates V.txdump > tmp
!mv tmp V.txdump
!awk -f remove_duplicates I.txdump > tmp
!mv tmp I.txdump
#
#S/N AND COUNT RATIO CUT
########
!awk '{if($3 > 0 && $5 > 0) print $0,$4/$3,$4/$5}' V.txdump > tmp
!awk '{if($6 > 1.5 && $7 > 2 && $7 < 10) print $0}' tmp > V.txdump
!awk '{if($3 > 0 && $5 > 0) print $0,$4/$3,$4/$5}' I.txdump > tmp
!awk '{if($6 > 1.5 && $7 > 2 && $7 < 10) print $0}' tmp > I.txdump
#
#SECOND PHOT
############
unlearn phot
unlearn datapars
unlearn photpars
unlearn centerpars
unlearn fitskypars
#
apphot.phot.interactive=no
apphot.phot.verify=no
# the gain is set to 
datapars.gain="exptime"
datapars.readnoise=0.0
datapars.filter="filtnam1"
datapars.obstime="obs-time"
datapars.sigma=INDEF
centerpars.cbox=10
centerpars.maxshift=10.
fitskypars.salgorithm="median"
fitskypars.dannulus=3.
# coords come from imexam so there is no need to recenter
centerpars.calgorithm="centroid"
#
#photpars.zmag=24.57
#phot image="V.fits[1]" coords="V.cand.coords" datapars.fwhmpsf=1.75 photpars.apertures="0.5" fitskypars.annulus=5.0 output="V.mag.2"
photpars.zmag=23.67
phot image="I.fits[1]" coords="I.cand.coords" datapars.fwhmpsf=1.80 photpars.apertures="0.5" fitskypars.annulus=5.0 output="I.mag.2"
#
#MAKEOBSFILE
############
mkobsfile *.mag.2 idfilter="F555W,F814W" observat="mkobsfile.out" imsets="galaxy.imsets" verify-
!awk '{if($2 ~ "F555W"){x=$0; next} else {print x,$0;}}' mkobsfile.out > tmp
!mv tmp mkobsfile.out
#
#CALC V-I COLOR
###############
!awk '{$3="";$4="";$9="";$11="";$12="";print $0,$7-$15}' mkobsfile.out > gc_cand_calib.dat
!awk '{if($12 > 0.5 && $12 < 1.5) print $0}' gc_cand_calib.dat > gc_cand_color_cut.dat
