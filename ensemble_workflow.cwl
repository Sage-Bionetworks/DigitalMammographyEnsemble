#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: Workflow

# input is an array of Docker references
inputs:
  models: string[]

outputs:
  result:
    type: File
    outputSource: aggregate/agg_out

requirements:
 - class: ScatterFeatureRequirement

# TODO instead of specifying an 'output_folder' let Toil create it
# TODO how do we allocate the two sets of resources (CPUs, GPUs, etc.) on a worker machine?
steps:
  sc1:
    run: dm_sc1.cwl
    scatter: value
    in:
      docker_image_reference: models
      images_data_folder: /data/data/dm_grouphealth/dcm/SC2_test
      images_crosswalk_tsv: /data/data/dm_grouphealth/metadata/SC2_test_images_crosswalk.tsv
      scratch_folder: /data/scratch0/
      output_folder: /data/inference0/
      docker_registry: docker.synapse.org
      docker_registry_auth: fill-in-base64-encoded-user-colon-password
      docker_container_name: cwl-sc1
      first_gpu_device: /dev/nvidia0
      second_gpu_device: /dev/nvidia1
      cpu_set: 1-15
    out: [incr_out]

  aggregate:
    run:  aggregation_tool.cwl
    in:
      value: sc1/inferences
    out: [agg_out]
