#!/bin/bash

###########################################################################################
# Author: Paulo Jannig | GitHub: https://github.com/paulojannig
#
# DESCRIPTION:
# This script will merge fastq files belonging to the same biological replicate but that were 
# run on separate lanes.
#
# USAGE:
# 1. Run the script using the command: 
#   sh merge_fastq.sh
#
# REQUIREMENTS:
# - none
#
###########################################################################################
#
# ===========================================================================================
# Script starts here...
# ===========================================================================================

source config.sh

# ===========================================================================================
# To merge fastq files from multiple lanes...
# ===========================================================================================
# 
# EXAMPLE:
# - Samples F_1_EKRN230018719 and B_1_EKRN230016099 were run on separate lanes and have multiple files (done to generate the minimum amount of data (6 Gb))
#
# Files: 
#   F_1_EKRN230018719:
#       Pair 1:
#           F_1_EKRN230018719-1A_HCKHGDSX7_L3_1.fq.gz
#           F_1_EKRN230018719-1A_HCKHGDSX7_L3_2.fq.gz
#       Pair 2:
#           F_1_EKRN230018719-1A_H3HGVDSX7_L3_1.fq.gz
#           F_1_EKRN230018719-1A_H3HGVDSX7_L3_2.fq.gz
#   B_1_EKRN230016099:
#       Pair 1:
#           B_1_EKRN230016099-1A_HWNVTDSX5_L3_1.fq.gz
#           B_1_EKRN230016099-1A_HWNVTDSX5_L3_2.fq.gz
#       Pair 2:
#           B_1_EKRN230016099-1A_HYCHTDSX5_L2_1.fq.gz
#           B_1_EKRN230016099-1A_HYCHTDSX5_L2_2.fq.gz
# Thus, we'll have to merge those files into only one pair


if [ $MULTIPLE_LANES = "yes" ]
then 

  mkdir -p ${PROJECT_FOLDER}/fastq_multiple_lanes # creates folder where unmerged fastq files will be stored
  mv ${PROJECT_FOLDER}/fastq/F_1_EKRN230018719-1A_* ${PROJECT_FOLDER}/fastq_multiple_lanes # move files there
  mv ${PROJECT_FOLDER}/fastq/B_1_EKRN230016099-1A* ${PROJECT_FOLDER}/fastq_multiple_lanes # move files there

  # merging F_1 files
  cat ${PROJECT_FOLDER}/fastq_multiple_lanes/F_1_EKRN230018719*_1.fq.gz > ${PROJECT_FOLDER}/fastq/F_1_EKRN230018719-1A_merged_L3_1.fq.gz # creates merged read1
  cat ${PROJECT_FOLDER}/fastq_multiple_lanes/F_1_EKRN230018719*_2.fq.gz > ${PROJECT_FOLDER}/fastq/F_1_EKRN230018719-1A_merged_L3_2.fq.gz # creates merged read2

  # merging B_1 files
  cat ${PROJECT_FOLDER}/fastq_multiple_lanes/B_1_EKRN230016099*_1.fq.gz > ${PROJECT_FOLDER}/fastq/B_1_EKRN230016099-1A_merged_L3_1.fq.gz # creates merged read1
  cat ${PROJECT_FOLDER}/fastq_multiple_lanes/B_1_EKRN230016099*_2.fq.gz > ${PROJECT_FOLDER}/fastq/B_1_EKRN230016099-1A_merged_L3_2.fq.gz # creates merged read2

elif [ $MULTIPLE_LANES = "no" ]
then
  exit 1
else
  echo "Unsupported MULTIPLE_LANES variable, check config.sh: $MULTIPLE_LANES"
  echo "Analysis will continue without merging files"
  exit 1
fi