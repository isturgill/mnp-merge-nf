# Reference download
## Human GRCh38 FASTA
To download the reference FASTA (~3GB), see ref/README.md and run the associated script in the ref directory:

```bash
bash 01-reference_download.sh
```

## Creating the codons.txt for merging
Ultimately, the Sentieon merging script considers merging only SNPs that co-occur within the same codon (that is, they affect the same translated amino acid residue). This is not difficult to create, but is a little bit involved. Please refer to the [Sentieon instructions](https://github.com/Sentieon/sentieon-scripts/tree/master/merge_mnp#example-usage---merging-only-variants-within-the-same-codon) which will walk you through each step. Expect the final `codons.txt` file to be roughly 4.8GB.
