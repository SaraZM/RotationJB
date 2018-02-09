from os.path import join as opj
import os
import json
from nipype.interfaces.fsl import (BET, ExtractROI, FAST, FLIRT, ImageMaths,
                                   MCFLIRT, SliceTimer, Threshold)
from nipype.interfaces.spm import Smooth
from nipype.interfaces.utility import IdentityInterface
from nipype.interfaces.io import SelectFiles, DataSink
from nipype.algorithms.rapidart import ArtifactDetect
from nipype.pipeline.engine import Workflow, Node


#os.system("ls Documentos/RotationJB/ds000105/sub-1/")
experiment_dir = '\output'
output_dir = 'datasink'
working_dir = 'workingdir'

subject_list = ['sub-1', 'sub-2', 'sub-3', 'sub-4', 'sub-5', 'sub-6']
fwhm=[4,8]
# full width at half maximum
#filter width in space
#task_list=['func']


with open('ds000105/task-objectviewing_bold.json', 'rt') as fp:
    task_info = json.load(fp)
TR=task_info['RepetitionTime']

iso_size=4

# ExtractROI - skip dummy scans
extract = Node(ExtractROI(t_min=4, t_size=-1), output_type='NIFTI', name="extract")

# MCFLIRT - motion correction
mcflirt = Node(MCFLIRT(mean_vol=True, save_plots=True, output_type='NIFTI'), name="mcflirt")


#SliceTimer - correct for slice wise acquisition
slicetimer = Node(SliceTimer(index_dir=False, interleaved=True,output_type='NIFTI',time_repetition=TR),name="slicetimer")

# Smooth - image smoothing
smooth = Node(Smooth(), name="smooth")
smooth.iterables = ("fwhm", fwhm)

# Artifact Detection - determines outliers in functional images
art = Node(ArtifactDetect(norm_threshold=2,zintensity_threshold=3, mask_type='spm_global',parameter_source='FSL',use_differences=[True, False], plot_type='svg'),name="art")

###

# BET - Skullstrip anatomical Image
bet_anat = Node(BET(frac=0.5,
                    robust=True,
                    output_type='NIFTI_GZ'),
                name="bet_anat")

# FAST - Image Segmentation
segmentation = Node(FAST(output_type='NIFTI_GZ'),
                    name="segmentation")
#
## Select WM segmentation file from segmentation output
def get_wm(files):
    return files[-1]
#
## Threshold - Threshold WM probability image
threshold = Node(Threshold(thresh=0.5,
                           args='-bin',
                           output_type='NIFTI_GZ'),
                name="threshold")
#
## FLIRT - pre-alignment of functional images to anatomical images
coreg_pre = Node(FLIRT(dof=6, output_type='NIFTI_GZ'),
                 name="coreg_pre")
#
## FLIRT - coregistration of functional images to anatomical images with BBR
coreg_bbr = Node(FLIRT(dof=6,
                       cost='bbr',
                       schedule=os.path.join(os.getenv('FSLDIR'),'etc/flirtsch/bbr.sch'),
                       output_type='NIFTI_GZ'),
                 name="coreg_bbr")
#
##Apply coregistration warp to functional images
applywarp = Node(FLIRT(interp='spline',
                       apply_isoxfm=iso_size,
                       output_type='NIFTI'),
                 name="applywarp")
#
##Apply coregistration warp to mean file
applywarp_mean = Node(FLIRT(interp='spline',
                            apply_isoxfm=iso_size,
                            output_type='NIFTI_GZ'),
                 name="applywarp_mean")
#
##Create a coregistration workflow
coregwf = Workflow(name='coregwf')
coregwf.base_dir = opj(experiment_dir, working_dir)
#
## Connect all components of the coregistration workflow
#coregwf.connect([(bet_anat, segmentation, [('out_file', 'in_files')]),
#                 (segmentation, threshold, [(('partial_volume_files', get_wm),
#                                             'in_file')]),
#                 (bet_anat, coreg_pre, [('out_file', 'reference')]),
#                 (threshold, coreg_bbr, [('out_file', 'wm_seg')]),
#                 (coreg_pre, coreg_bbr, [('out_matrix_file', 'in_matrix_file')]),
#                 (coreg_bbr, applywarp, [('out_matrix_file', 'in_matrix_file')]),
#                 (bet_anat, applywarp, [('out_file', 'reference')]),
#                 (coreg_bbr, applywarp_mean, [('out_matrix_file', 'in_matrix_file')]),
#                 (bet_anat, applywarp_mean, [('out_file', 'reference')]),
#                 ])
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
