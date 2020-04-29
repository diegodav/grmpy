---
layout: default
title: GRMPY_822831 Image Processing Workflow
parent: Flywheel
nav_order: 6
has_toc: false
---

# GRMPY_822831 Image Processing Workflow
This is documentation of how GRMPY_822831 was processed on Flywheel. All files referenced in input can be found attached to the project. 

## Steps Overview:
Each step is a flywheel gear that has been launched on each subject in the project. 
1. Heudiconv
2. fMRIPREP
3. XCP - CBF
4. XCP - Resting State Functional
5. XCP - Task Functional

## Step 1: Heudiconv


**Gear Name:** Flywheel HeuDiConv (fw-heudiconv)


**Version:** 0.2.10_0.2.4


**Inputs:** 

Heuristic: grmpy_heuristic_v4.py


**Gear Configuration:** 

action: Curate

do_whole_project: false

dry_run: false

extended_bids: true

**Output:** None. This curates the project in BIDS. 


**Note:** When Processing GRMPY_822831, heudiconv was run on each subject individually. This is why do_whole_project was set to false.


## Step 2: fMRIPREP


**Gear Name:** fMRIPREP: A Robust Preprocessing Pipeline for fMRI Data [fw-heudiconv]


**Version:** 0.3.2_20.0.5


**Inputs:** license.txt


**Gear Configuration:** 

anat_only:	false

aroma_melodic_dimensionality:	-200

bold2t1w_dof:	6

cifti_output:	None

dummy_scans:	0

dvars_spike_threshold:	1.5

fd_spike_threshold:	0.5

fmap_bspline:	false

fmap_no_demean:	false

force_bbr:	false

force_no_bbr:	false

force_syn:	false

fs_no_reconall:	false

longitudinal:	false

low_mem:	false

medial_surface_nan:	false

no_submm_recon:	false

no_track:	false

output_spaces:	MNI152NLin2009cAsym

return_all_components:	false

save_intermediate_work:	false

save_outputs:	false

sge-cpu:	8

sge-ram:	64G

sge-short:	false

singularity-debug:	false

singularity-writable:	false

skip_bids_validation:	false

skull_strip_fixed_seed:	false

skull_strip_template:	OASIS30ANTs

sloppy_mode:	false

t2s_coreg:	false

timeout:	2

use_all_sessions:	false

use_aroma:	false

use_syn_sdc:	false


**Output:**

An html report: filename.html.zip

Processed Output: fmriprep_filename.zip

Source Code: fmriprep_run.sh


## Step 3: XCP - CBF


**Gear Name:** XCPENGINE: pipeline for processing of structural and functional data.


**Version:** 0.0.1_1.00


**Inputs:** 

fMRIPREP Output: fmriprep_filename.zip

Design File: cbf_scorescrub_basil_v3.dsn

ASL Nifti: asl_image.nii.gz


**Gear Configuration:** 

analysis_type:	cbf


**Output:**

Processed Output: xcpEngineouput_cbf.zip

Cohort File: cohortfile.csv


## Step 4: XCP - Resting State Functional


**Gear Name:** XCPENGINE: pipeline for processing of structural and functional data.


**Version:** 0.0.1_1.00


**Inputs:** 

fMRIPREP Output: fmriprep_filename.zip

Design File: fc-36p_despike.dsn


**Gear Configuration:**

analysis type:	func

analysis type:	xcp


**Output:** 

Processed Output: xcpEngineouput_xcp.zip

Cohort File: cohortfile.csv


## Step 5: XCP - Task Functional


**Gear Name:** XCPENGINE: pipeline for processing of structural and functional data.


**Version:** 0.0.1_1.00


**Inputs:** 

fMRIPREP Output: fmriprep_filename.zip

Design File: 

Zip of necessary files: taskfile.zip

*Note:* files within the .zip are: 

0back.txt

1back.txt

2back.txt

inst.txt

task.json


**Gear Configuration:**

analysis type:	task

analysis type:	xcp


**Output:** 

Processed Output: xcpEngineouput_xcp.zip

Cohort File: cohortfile.csv

