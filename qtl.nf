#!/usr/bin/env nextflow 
nextflow.enable.dsl = 2

params.bed = '*.bed'
params.bedindex = '*bed.tbi'
params.vcf = '*.vcf'
params.vcfindex = '*.vcf.tbi'
params.cov = '*.txt'

process qtl {
    container = 'sagebionetworks/dockstore-tool-qtltools:latest'

    input:
      path bed
      path bedindex
      path vcf
      path vcfindex
      path cov
    output:
      path 'nominals.txt'

    script:
      """
      QTLtools cis --vcf $vcf --bed $bed --cov $cov --out nominals.txt --normal --nominal 0.01
      """
}

workflow {
    bed = channel.fromPath(params.bed)
    bedindex = channel.fromPath(params.bedindex)
    vcf = channel.fromPath(params.vcf)
    vcfindex = channel.fromPath(params.vcfindex)
    cov = channel.fromPath(params.cov)
    qtl(bed,bedindex,vcf,vcfindex,cov)
    qtl.out.view()
}
