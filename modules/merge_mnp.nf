#!/usr/bin/env nextflow
nextflow.enable.dsl=2

process MERGE_MNP {
    // Uses a Pixi Docker image with Python dependencies for the Sentieon merge scripts
    tag "$sample_id"
    container "ghcr.io/isturgill/mnp-merge:1.0.0"
    publishDir "${params.outdir}", mode: 'copy'

    input:
    tuple val(sample_id), path(phased_vcf), path(phased_vcf_tbi)
    path(fasta)
    path(fasta_fai)
    path(codons)

    output:
    // 
    path("${sample_id}.merged.vcf"), emit: results

    script:
    """
    pixi run python /scripts/merge_mnp_varscan.py \
        ${phased_vcf} \
        ${fasta} \
        merge_by_codon \
        ${codons} \
        --out_file ${sample_id}.merged.vcf
    """
}