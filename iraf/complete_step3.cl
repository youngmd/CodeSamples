# Initialize the parameters
unlearn tcreate
unlearn rename
unlearn delete
unlearn tmatch
#
# PARAMETERS TO CHANGE
##############################################################################
# Change these parameters depending on the filter
#
# This is the filter itself
s1 = "b"
#
# Change the value of start depending on what instr. mag range you're using
# increment is the magnitude step (i.e., the bins are currently 0.2 mag wide)
# steps is the number of steps to take
#
# Do a search and replace on the galaxy name
#
real start,increment,high_mag
int steps,q
start = -4.1
increment = 0.2
steps = 40
##############################################################################
#
for (q = 0; q < 3; q+=1){

if(q == 0){
  s1 = "b"
}

if(q == 1){
  s1 = "v"
}

if(q == 2){
  s1 = "r"
}
#
for (i = 1; i <= steps; i+=1) {

high_mag = start + increment * i

# Create the artificial star table 
tcreate.nlines=0
tcreate ("art_star_list."//(s1)//"."//(high_mag)//".tab", "art_table.description", "n7332_"//(s1)//"_gcs_add."//(high_mag)//".pselect")

# Reformat the phot output so that it can be read with tcreate
rename ("n7332_"//(s1)//"_gcs_add."//(high_mag)//".mag.1a", "tempphot1")
!awk -f remove_backslashes tempphot1 > tempphot2
rename ("tempphot2", "n7332_"//(s1)//"_gcs_add."//(high_mag)//".mag.1a")
delete ("tempphot1", yes)

# Create the phot output table
tcreate.nlines=5
tcreate("phot_output."//(s1)//"."//(high_mag)//".tab","phot_table.description","n7332_"//(s1)//"_gcs_add."//(high_mag)//".mag.1a")

# Match the artificial stars with the stars detected by daofind
# and measured with phot
tmatch.incol1 = "ID, XCEN, YCEN, MAG"
tmatch.incol2 = "ID, XINIT, YINIT, MAG, MERR, IFILTER"
tmatch ("art_star_list."//(s1)//"."//(high_mag)//".tab", "phot_output."//(s1)//"."//(high_mag)//".tab", "n7332_"//(s1)//"."//(high_mag)//"_tmatch", "xcen,ycen", "xinit,yinit", 6.)

# Now dump the table output to an ASCII file
tdump.datafile="n7332_"//(s1)//"."//(high_mag)//"_tmatch.tdump"
tdump ("n7332_"//(s1)//"."//(high_mag)//"_tmatch")
}

}
# Reset delete verify parameter!
#
delete.verify=yes



