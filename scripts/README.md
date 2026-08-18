# Sentieon MNP Merge Scripts License
The merge scripts are provided by [Sentieon](https://github.com/Sentieon/sentieon-scripts) under a BSD-2-Clause license:
BSD 2-Clause License

Copyright (c) Sentieon Inc. All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:

* Redistributions of source code must retain the above copyright notice, this
list of conditions and the following disclaimer.

* Redistributions in binary form must reproduce the above copyright notice,
this list of conditions and the following disclaimer in the documentation
and/or other materials provided with the distribution.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

# Script Details
## Original Scripts
The following merge scripts are redistributed in an unaltered form:
* [merge_by_codon-preprocess_codon_file.awk](https://github.com/Sentieon/sentieon-scripts/blob/master/merge_mnp/merge_by_codon-preprocess_codon_file.awk)
* [merge_by_codon.py](https://github.com/Sentieon/sentieon-scripts/blob/master/merge_mnp/merge_by_codon.py)
* [merge_mnp.py](https://github.com/Sentieon/sentieon-scripts/blob/master/merge_mnp/merge_mnp.py)

## New, small addition
An additional script, merge_mnp_varscan.py has been slightly modified here for use in parsing VarScan2 VCF files, which have a non-standard format.

Namely, standard format VCFs provide AD as two values for reference depth and alternate depth. VarScan2 provides these separately as RD and AD.
Simple diff:
143,144c148,149
> <             ads = [(vi["AD"][0], vi["AD"][1]) for vi in vv_samples]
> <             t["AD"] = (int(sum([vi["AD"][0] for vi in vv_samples])/len_vv), int(sum([vi["AD"][1] for vi in vv_samples])/len_vv))
> ---
> \>            ads = [(vi["AD"][0], vi["RD"]) for vi in vv_samples]
> \>            t["AD"] = (int(sum([vi["AD"][0] for vi in vv_samples])/len_vv), int(sum([vi["RD"] for vi in vv_samples])/len_vv))
