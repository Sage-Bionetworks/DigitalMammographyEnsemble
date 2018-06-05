#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: Workflow

# input is an array of Docker references
inputs:
  models: string[][]

outputs:
  result:
    type: File
    outputSource: aggregate/agg_out

requirements:
 - class: ScatterFeatureRequirement

# TODO instead of specifying an 'output_folder' let Toil create it
# TODO how do we allocate the two sets of resources (CPUs, GPUs, etc.) on a worker machine?
steps:
  inference:
    run: dm_inference.cwl
    scatter: value
    in:
      docker_image_reference: models
      images_data_folder: /data/data/dm_challenge_model_test_datasets/dcm/SC2_single_subject
      images_crosswalk_tsv: /data/data/dm_challenge_model_test_datasets/metadata/SC2_single_subject_images_crosswalk.tsv
      exams_metadata: /data/data/dm_challenge_model_test_datasets/metadata/SC2_single_subject_exams_metadata.tsv
      scratch_folder: /data/scratch0
      host_workdir: /home/dreamuser/DigitalMammographyEnsemble
      docker_registry: docker.synapse.org
      docker_registry_auth: fill-in-base64-encoded-user-colon-password
      docker_container_name: cwl-sc2
      first_gpu_device: /dev/nvidia0
      second_gpu_device: /dev/nvidia1
      cpu_set: 1-15
    out: [incr_out]

  aggregate:
    run:  aggregation_tool.cwl
    in:
      value: inference/inferences
    out: [agg_out]
