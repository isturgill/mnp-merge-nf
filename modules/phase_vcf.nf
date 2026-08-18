#!/usr/bin/env nextflow
nextflow.enable.dsl=2

process PHASE_VCF {
    // Uses whatshap to include phase information for VCF variants
    tag "$sample_id"
    container "quay.io/biocontainers/whatshap:2.8--py39h2de1943_0"

    input:
    tuple val(sample_id), path(normal_bam), path(normal_bai), path(tumor_bam), path(tumor_bai), path(vcf)
    path(fasta)
    path(fasta_fai)

    output:
    tuple val(sample_id), path("*.phased.vcf.gz"), path("*.phased.vcf.gz.tbi"), emit: results

    script:
    """
    # whatshap expects bgzip-compressed and tabix-indexed files
    if [[ "${vcf}" != *.gz ]]; then
        bgzip ${vcf}
        vcf_gz="${vcf}.gz"
    else
        vcf_gz=${vcf}
    fi

    tabix -p vcf \${vcf_gz} || true

    # Check if the VCF has already been phased. If it has, it can be skipped to the merge process.
    # For example, Mutect2 VCFs may or may not have phase information.
    if ! zgrep -qP "PID|PGT|PS" \${vcf_gz}; then

        # Run whatshap phase
        whatshap phase -o ${sample_id}.phased.vcf.gz \
            --reference=${fasta} \
            \${vcf_gz} \
            ${normal_bam} \
            ${tumor_bam}

    else
        mv \${vcf_gz} ${sample_id}.phased.vcf.gz

    # Generate the tabix index file for the new phased VCF
    tabix -p vcf ${sample_id}.phased.vcf.gz
    """
}