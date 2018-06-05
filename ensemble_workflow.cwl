#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: Workflow

inputs:
  models:
    type:
      type: array
      items:
        type: record
        fields:
          - name: name
            type: string
          - name: weight
            type: float
          - name: docker_reference
            type: string

outputs:
  - id: ensemble_predictions
    type: File
    outputSource: aggregate/ensemble_predictions
  - id: ensemble_predictions_exams
    type: File
    outputSource: aggregate/ensemble_predictions_exams

requirements:
 - class: ScatterFeatureRequirement

steps:
  inference:
    run: dm_inference.cwl
    scatter: model
    in:
      - id: model
        source: "#models"
      - id: images_data_folder
        valueFrom: /data/data/dm_challenge_model_test_datasets/dcm/SC2_single_subject
      - id: images_crosswalk_tsv
        valueFrom: /data/data/dm_challenge_model_test_datasets/metadata/SC2_single_subject_images_crosswalk.tsv
      - id: exams_metadata
        valueFrom: /data/data/dm_challenge_model_test_datasets/metadata/SC2_single_subject_exams_metadata.tsv
      - id: scratch_folder
        valueFrom: /data/scratch0
      - id: host_workdir
        valueFrom: /home/dreamuser/DigitalMammographyEnsemble
      - id: docker_registry
        valueFrom: docker.synapse.org
      - id: docker_registry_auth
        valueFrom: fill-in-base64-encoded-user-colon-password
      - id: docker_container_prefix
        valueFrom: dm
      - id: first_gpu_device
        valueFrom: /dev/nvidia0
      - id: second_gpu_device
        valueFrom: /dev/nvidia1
      - id: cpu_set
        valueFrom: 1-15
      - id: entry_point
        valueFrom: /sc2_infer.sh
    out:
      - id: predictions
      - id: predictions_exams
      
  aggregate:
    run:  dummy_aggregation_tool.cwl
    in:
      - id: models
        source: "#models"
      - id: predictions
        source: "#inference/predictions"
      - id: predictions_exams
        source: "#inference/predictions_exams"
    out:
      - id: ensemble_predictions
      - id: ensemble_predictions_exams
