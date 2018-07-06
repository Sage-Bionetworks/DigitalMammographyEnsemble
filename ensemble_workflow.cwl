#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: Workflow

inputs:
  - id: models
    type:
      type: array
      items:
        type: record
        fields:
          - name: name
            type: string
          - name: weight
            type: float  
          - name: weight_r
            type: float  
          - name: weight_re
            type: float  
          - name: weight_e
            type: float
          - name: docker_reference
            type: string

  - id: precomputed_predictions
    type:
      type: array
      items:
        type: record
        fields:
          - name: name
            type: string
          - name: weight
            type: float
          - name: weight_r
            type: float
          - name: weight_re
            type: float
          - name: weight_e
            type: float
          - name: predictions
            type: File
          - name: predictions_exams
            type: File

  - id: intercept
    type:
      type: record
      fields:
        - name: weight
          type: float  
        - name: weight_r
          type: float  
        - name: weight_re
          type: float  
        - name: weight_e
          type: float  

outputs:
  - id: ensemble_predictions
    type: File
    outputSource: aggregate/ensemble_predictions
  - id: ensemble_predictions_exams
    type: File
    outputSource: aggregate/ensemble_predictions_exams
  - id: output
    type: File
    outputSource: aggregate/output
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
        source: "#images_data_folder"
      - id: images_crosswalk_tsv
        source: "#images_crosswalk_tsv"
      - id: exams_metadata
         source: "#exams_metadata"
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
    run:  aggregation_tool.cwl
    in:
      - id: executed_models
        source: "#models"
      - id: predictions
        source: "#inference/predictions"
      - id: predictions_exams
        source: "#inference/predictions_exams"
    out:
      - id: ensemble_predictions
      - id: ensemble_predictions_exams
      - id: output