#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

include { NEXTCLADENEW_DATASET } from '../../../../modules/nextcladenew/dataset/main.nf'

workflow test_nextcladenew_dataset {

    input = [
        [ id:'test', single_end:false ], // meta map
        file(params.test_data['sarscov2']['genome']['genome_fasta'], checkIfExists: true)
    ]

    dataset_name = "sars-cov-2"

    NEXTCLADENEW_DATASET ( input , dataset_name)
}
