#!/bin/bash
# This script downloads the specified data files from the NCBI FTP server hosting SEQ2C data.
FTP_DIR="https://ftp-trace.ncbi.nlm.nih.gov/ReferenceSamples/seqc/Somatic_Mutation_WG/data/WES"
FILES=("WES_EA_N_1.bwa.dedup.bam" "WES_EA_N_1.bwa.dedup.bai" "WES_EA_T_1.bwa.dedup.bam" "WES_EA_T_1.bwa.dedup.bai")

cd "$(dirname "${BASH_SOURCE[0]}")"
set -euo pipefail

# Iterate through and download each of the data files
for f in "${FILES[@]}"; 
do
	wget --show-progress ${FTP_DIR}/${f}
done
