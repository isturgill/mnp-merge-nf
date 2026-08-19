# Example data
## Data download
Specific files were downloaded from the [NCBI FTP server](https://ftp-trace.ncbi.nlm.nih.gov/ReferenceSamples/seqc/Somatic_Mutation_WG/) hosting [SEQ2C Consortium](https://sites.google.com/view/seqc2/home) genomics data. The SEQ2C Consortium makes available a complete set of data for the purposes of standardization and benchmarking and is a good resource for open access variant calling data. 

Example files downloaded for demonstration purposes include a tumor-normal matched BAM pair (WES_EA_N_1 and WES_EA_T_1) with their associated BAM index (`.bai`) files and the GRCh38.d1.vd1.fa human reference FASTA and FASTA index (`.fai`) that was used in mapping to create those BAM files.

## Download script
To download the sample BAMs (~22GB), run:

```bash
bash 01-data_download.sh
```

To download the reference FASTA (~3GB), see ref/README.md and run the associated script in the ref directory:

```bash
bash 01-reference_download.sh
```

## Running VarScan2 on example data
Running VarScan2 requires an installation of [Docker](https://docs.docker.com/desktop/setup/install/linux/) (browse for suitable instructions for your system OS). Once installed, run:

```bash
bash 02-run_varscan.sh
```

This will create a series of variant call VCF files in the varscan2 directory. The main file of interest for downstream phasing and merging for demonstration is `WES_EA.snp.Somatic.hc.vcf` (or `WES_EA.snp.Somatic.hc.vcf.gz`), which contains high-confidence VarScan2 somatic variant calls. In real workflows, you may have additional pre- and/or post-merge filtering.
