# want to make sure I'm running the right version of phot; otherwise
# an error results 
daophot
# Initialize all of the psets
unlearn addstar
unlearn datapars
unlearn datapars
unlearn daopars
unlearn daofind
unlearn findpars
unlearn phot
unlearn photpars
unlearn centerpars
unlearn fitskypars
real start,increment,low_mag,high_mag
int steps,q
#
# PARAMETERS TO CHANGE
##############################################################################
# Change these parameters depending on the filter
# Do a search and replace on the galaxy name.
#
for (q = 0; q < 3; q+=1){

if(q == 0){
  s1 = "b"
  x=6.612
  datapars.sigma=9.7
  findpars.threshold=4.0
  datapars.datamax=55000
}

if(q == 1){
  s1 = "v"
  x=7.056
  datapars.sigma=18.2
  findpars.threshold=3.5
  datapars.datamax=55000.
}

if(q == 2){
  s1 = "r"
  x=7.393
  datapars.sigma=23.4
  findpars.threshold=3.0
  datapars.datamax=55000.
}
#
# Change the value of start and increment depending on what instr. mag range you want;
#
start = -4.1
increment = 0.2
steps = 40
#add setting for nstar up here?
#
##############################################################################
#
# Save the initial maxmag value for use in filenames later
#
# These parameters stay constant
datapars.fwhmpsf=x
daopars.psfrad=nint(4.0*x)
daopars.fitrad=x
datapars.ccdread="rdnoise"
datapars.gain="gain"
datapars.exposure="exptime"
datapars.airmass="airmass"
datapars.filter="filter"
datapars.obstime="time-obs"
#
# I *guess* this is the correct aperture to use...if we're not using
# aperture corrections for this step...???
#
photpars.apertures=nint(4*x)
fitskypars.annulus=nint(5*x)
phot.interactive=no
phot.verify=no
phot.update=no
phot.verbose=no
photpars.zmag=0.
centerpars.cbox=9.
centerpars.maxshift=3.
fitskypars.salgorithm="median"
fitskypars.dannulus=10.
addstar.nstar=200
addstar.idoffset=40000
addstar.verbose=no
addstar.verify=no
addstar.update=no
daofind.graphics="STDGRAPH"
daofind.display="STDIMAGE"
daofind.verify=no
daofind.update=no
daofind.verbose=no
imdelete.verify=no
#
# Run addstar to add artificial stars to the images
for (i = 0; i < steps; i+=1) {
low_mag = start + increment * i
high_mag = start + increment * (i + 1)
addstar ("n7332_"//(s1)//"_gcs", "", "default", "n7332_"//(s1)//"_gcs_add."//(high_mag), low_mag, high_mag, 200)
#
#check to see if order of low_mag,high_mag matters
#see if addstar needs nstar variable during call
#
# order does NOT matter, addstar is smart enough to figure out which is which
#
daofind ("n7332_"//(s1)//"_gcs_add."//(high_mag)//".fits", "default")
phot ("n7332_"//(s1)//"_gcs_add."//(high_mag), "n7332_"//(s1)//"_gcs_add."//(high_mag)//".fits.coo.1", "default", "")
imdel ("n7332_"//(s1)//"_gcs_add."//(high_mag), yes)
}
}
#
# Reset imdelete verify parameter!
#
imdelete.verify=yes
