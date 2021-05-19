# nextflow-workflow-eQTL

## Tool Execution

- To run this workflow using the docker image hosted by Sage:

`nextflow run qtl.nf -profile docker`


## Input requirements

This tool assumes that you have [QTLTools cis](https://qtltools.github.io/qtltools/) input files in your project directory that match the following glob patterns:

- `*.bed`
- `*bed.tbi`
- `*.vcf`
- `*.vcf.tbi`
- `*.txt` 


## TODO/Work in Progress

- create main.nf workflow and use qtools as a module
- improve flexibility of input paths
- improve input/output staging
- Add documentation to workflow/tool code
