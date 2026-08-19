#!/bin/bash
# Runs a quick check of potential SNPs that should be merged.
# Requires DuckDB installation.

VCF="WES_EA.snp.Somatic.hc.vcf"

cd "$(dirname "${BASH_SOURCE[0]}")"
set -euo pipefail

# Left self-join, filtering to rows where variants are within
# +/- 2bp of each other on the same chromosome
# Generally: candidates for SNP merging if they are in-phase
duckdb -c "
	SELECT DISTINCT * FROM READ_CSV(\"${VCF}\") t1 
	LEFT JOIN READ_CSV(\"${VCF}\") t2 
		ON t2.POS BETWEEN t1.POS -2 AND t1.POS + 2 AND t1.POS != t2.POS AND t1.\"#CHROM\" = t2.\"#CHROM\" 
	WHERE t1.FILTER = 'PASS' AND t2.filter = 'PASS'
	ORDER BY t1.\"#CHROM\", t1.POS
"
