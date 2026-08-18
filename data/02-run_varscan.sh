#!/bin/bash
# This script first runs samtools mpileup individually on normal and tumor BAMs.
# The mpileups are then used with VarScan2 for somatic variant calling. 
# Note: FASTA and BAM files should have associated index files in the same directory
DOCKER="mgibio/varscan-cwl:v2.4.2-samtools1.16.1"
REF_FASTA="ref/GRCh38.d1.vd1.fa"
NORMAL_BAM="data/WES_EA_N_1.bwa.dedup.bam"
TUMOR_BAM="data/WES_EA_T_1.bwa.dedup.bam"
SAMPLE=$(basename ${NORMAL_BAM} _N_1.bwa.dedup.bam)
NORMAL_PILEUP="data/varscan2/${SAMPLE}.normal.pileup"
TUMOR_PILEUP="data/varscan2/${SAMPLE}.tumor.pileup"
SNP="data/varscan2/${SAMPLE}.snp.vcf"

cd "$(dirname "${BASH_SOURCE[0]}")"
set -euo pipefail
mkdir -p varscan2

docker run --rm --user $(id -u):$(id -g) -v ..:/data -w /data ${DOCKER} \
	bash -c '
		# Generate mpileup files for both normal and tumor BAMs
		samtools mpileup -f '"${REF_FASTA}"' -q 1 -B '"${NORMAL_BAM}"' > '"${NORMAL_PILEUP}"' & \
		normal_pid=$!
		samtools mpileup -f '"${REF_FASTA}"' -q 1 -B '"${TUMOR_BAM}"' > '"${TUMOR_PILEUP}"' & \
		tumor_pid=$!
		
		# Wait for both processes to finish before proceeding to VarScan2
		wait $normal_pid
		wait $tumor_pid

		# Run VarScan2 and output as VCF
		java -Xmx8G -jar /opt/varscan/VarScan.jar somatic \
			'"${NORMAL_PILEUP}"' \ 
			'"${TUMOR_PILEUP}"' \
			data/varscan2/'"${SAMPLE}"' \
			--output-vcf
		
		# Split variants into somatic and germline files
		java -Xmx8G -jar /opt/varscan/Varscan.jar processSomatic '"${SNP}"'  
	'
