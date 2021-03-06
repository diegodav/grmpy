#!/bin/bash
#AFGR August 5 2016

###################################################################################################
##########################             GRMPY Volume Script               ##########################
##########################              Robert Jirsaraie                 ##########################
##########################             rjirsara@upenn.edu                ##########################
##########################                  08/05/2017                   ##########################
###################################################################################################
#####  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  #####
###################################################################################################

# This script is used to combine Volume data into JFL and ANTs CT Spreadsheets with correct headers.
## edited by Azeez for microbiome subset of the GRMPY data 

###################################################################################################
#####  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  #####
###################################################################################################

###########################
### Delcare Any Statics ###
###########################

jlfDirectory="/data/jux/BBL/studies/grmpy/microbiome/output/structural/"
jlfVolDir="/data/jux/BBL/studies/grmpy/microbiome/script/struct/autoQA/"
ctDirectory="/data/jux/BBL/studies/grmpy/microbiome/output/structural/"
scriptsDir="/data/jux/BBL/studies/grmpy/microbiome/script/struct/autoQA"
subjInfoDir="/data/jux/BBL/studies/grmpy/microbiome/script/struct/manualQA/"

#######################################################
### Create the raw volume output for the jlf labels ###
#######################################################

rm -f ${jlfVolDir}jlfVolValues_20160805.txt
for i in `find ${jlfDirectory} -name "*maskedJLFParcel.nii.gz"` ; do vals=`fslstats ${i} -H 208 0 207` ; echo ${i} ${vals} ; done >> ${jlfVolDir}jlfVolValues_20160805.txt

#################################
### Now for the antsCT values ###
#################################

rm -f ${jlfVolDir}ctVolValues_20160805.txt
for i in `find ${ctDirectory} -maxdepth 12 -name "*BrainSegmentation.nii.gz"` ; do vals=`fslstats ${i} -H 7 0 6` ; echo ${i} ${vals} ; done >> ${jlfVolDir}ctVolValues_20160805.txt

###############################################################
### Fix the subject fields using an *NON FLEXIBLE R SCRIPT* ###
###############################################################

R --slave -f ${scriptsDir}/prepSubjFields.R ${jlfVolDir}jlfVolValues_20160805.txt
R --slave -f ${scriptsDir}/prepSubjFields.R ${jlfVolDir}ctVolValues_20160805.txt

############################################################
### Adjust the Headers of the Proper Subject field files ###
############################################################

R --slave -f ${scriptsDir}/prepVolHeader.R ${jlfVolDir}jlfVolValues_20160805properSubjFields.csv
R --slave -f ${scriptsDir}/prepCtHeader.R ${jlfVolDir}ctVolValues_20160805properSubjFields.csv

###########################################
### Find Voxel Dimensions for each scan ###
###########################################

for i in `find ${jlfDirectory} -name "*Labels.nii.gz"` ; do 
  xDim=`fslinfo ${i} | grep pixdim1 | cut -f 9 -d ' '`
  yDim=`fslinfo ${i} | grep pixdim2 | cut -f 9 -d ' '`
  zDim=`fslinfo ${i} | grep pixdim3 | cut -f 9 -d ' '`
  voxDem=`echo "${xDim}*${yDim}*${zDim}" | bc`
  echo ${i} ${voxDem} >> ${jlfVolDir}voxelVolume_20160805.txt ; 
done

#####################################################
### Combine the Manual Ratings, JLF and CT values ###
#####################################################

R --slave -f ${scriptsDir}/prepSubjFields.R ${jlfVolDir}voxelVolume_20160805.txt
R --slave -f ${scriptsDir}/prepcombineVolVals.R

################
### Clean up ###
################

rm -f ${jlfVolDir}*properSubjField.csv ${jlfVolDir}voxelVolume_20160805.txt ${jlfVolDir}ctVolValues_20160805.txt ${jlfVolDir}jlfVolValues_20160805.txt


###################################################################################################
#####  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  ⚡  #####
###################################################################################################
