#!/usr/bin/env nextflow 
nextflow.enable.dsl = 2

params.bedid = 'syn25756263'
params.bedindexid = 'syn25756266'
params.vcfid = 'syn25756268'
params.vcfindexid = 'syn25756269'
params.covid = 'syn25756267'

params.synconfig = '.synapseConfig'

include { get as get_bed } from './modules/synapse.nf'
include { get as get_bedindex } from './modules/synapse.nf'
include { get as get_vcf } from './modules/synapse.nf'
include { get as get_vcfindex } from './modules/synapse.nf'
include { get as get_cov } from './modules/synapse.nf'


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
    

    synconfig = channel.fromPath(params.synconfig)

    get_bed(synconfig,params.bedid)
    get_bedindex(synconfig,params.bedindexid)
    get_vcf(synconfig,params.vcfid)
    get_vcfindex(synconfig,params.vcfindexid)
    get_cov(synconfig,params.covid)

    bed = get_bed.out.collect()    
    bedindex = get_bedindex.out.collect()
    vcf = get_vcf.out.collect()
    vcfindex = get_vcfindex.out.collect()
    cov = get_cov.out.collect()

    qtl(bed,bedindex,vcf,vcfindex,cov)
    qtl.out.view()
}
