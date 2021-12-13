process NEXTCLADENEW_DATASET {
    tag "$meta.id"
    label 'process_low'

    conda (params.enable_conda ? "bioconda::nextclade=1.7.0" : null)
    container "${ workflow.containerEngine == 'singularity' && !task.ext.singularity_pull_docker_container ?
        'https://depot.galaxyproject.org/singularity/nextclade:1.7.0--h9ee0642_0':
        'quay.io/biocontainers/nextclade:1.7.0--h9ee0642_0' }"

    input:
    tuple val(meta)
    val dataset_name

    output:
    // TODO nf-core: Named file extensions MUST be emitted for ALL output channels
    // tuple val(meta), path("*.bam"), emit: bam
    // path "genemap.gff"            , emit: gff
    // path "primers.csv"            , emit: primers
    // path "qc.json"                , emit: qc
    // path "reference.fasta"        , emit: reference
    // path "sequences.fasta"        , emit: sequences
    // path "tag.json"               , emit: tags
    // path "tree.json"              , emit: tree
    path "."                      , emit: dataset_directory

    path "versions.yml"           , emit: versions

    script:
    def args = task.ext.args ?: ''
    def prefix = task.ext.prefix ?: "${meta.id}"

    """
    nextclade \\
        dataset \\
        get \\
        $args \\
        --name=$dataset_name \\
        --output-dir='.'

    cat <<-END_VERSIONS > versions.yml
    "${task.process}":
        nextcladenew: \$(echo \$(nextclade --version 2>&1) )
    END_VERSIONS
    """
}
