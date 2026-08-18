#!/bin/bash
# This script downloads the specified reference files from the NCBI FTP server hosting SEQ2C data.
FTP_DIR="https://ftp-trace.ncbi.nlm.nih.gov/ReferenceSamples/seqc/Somatic_Mutation_WG/technical/reference_genome/GRCh38"
FILES=("GRCh38.d1.vd1.fa" "GRCh38.d1.vd1.fa.fai")

cd "$(dirname "${BASH_SOURCE[0]}")"
set -euo pipefail

# Iterate through and download each of the reference files
for f in "${FILES[@]}"; 
do
	wget --show-progress ${FTP_DIR}/${f}
done
