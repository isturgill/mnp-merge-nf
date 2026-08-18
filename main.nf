#!/usr/bin/env nextflow
nextflow.enable.dsl=2

// Import process modules
include { PHASE_VCF } from './modules/phase_vcf.nf'
include { MERGE_MNP } from './modules/merge_mnp.nf'

workflow {
    // Read samplesheet
	// Header: sample_id,normal_bam,normal_bai,tumor_bam,tumor_bai,vcf
    Channel
        .fromPath(params.samplesheet)
        .splitCsv(header: true)
        .map { row -> 
			tuple(
				row.sample_id, 
				file(row.normal_bam),
				file(row.normal_bai),
				file(row.tumor_bam),
				file(row.tumor_bai),
				file(row.vcf)
			) 
		}
        .set { samples_ch }

	// Stage references
	fasta_ch = file(params.reference_fasta)
	fasta_fai_ch = file(params.reference_fasta_fai)
    codons_ch    = file(params.codons)

    // Run processes
    PHASE_VCF(samples_ch, fasta_ch, fasta_fai_ch)
    MERGE_MNP(PHASE_VCF.out.results, fasta_ch, fasta_fai_ch, codons_ch)
}
