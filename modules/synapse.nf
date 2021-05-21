#!/usr/bin/env nextflow 
nextflow.enable.dsl = 2

params.synconfig = '.synapseConfig'
params.synid = false 

process get {
    container = 'sagebionetworks/synapsepythonclient:v1.9.2'

    input:
      path synconfig
      val synid
    output:
      path "*", emit: synapse_output
    script:
      """
      synapse -c $synconfig get $synid
      """
}

