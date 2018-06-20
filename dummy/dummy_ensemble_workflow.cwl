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
  - id: images_crosswalk_tsv
    type: string
  - id: exams_metadata
    type: string

outputs:
  - id: ensemble_predictions
    type: File
    outputSource: aggregate/ensemble_predictions
  - id: ensemble_predictions_exams
    type: File
    outputSource: aggregate/ensemble_predictions_exams
  - id: std_out
    type: File
    outputSource: aggregate/std_out
  - id: std_err
    type: File
    outputSource: aggregate/std_err

requirements:
 - class: ScatterFeatureRequirement
 - class: InlineJavascriptRequirement

steps:
  inference:
    run: dm_dummy_inference_tool.cwl
    scatter: model
    in:
      - id: images_crosswalk_tsv
        source: "#images_crosswalk_tsv"
      - id: exams_metadata
        source: "#exams_metadata"
      - id: model
        source: "#models"
    out:
      - id: predictions
      - id: predictions_exams

  aggregate:
    run:  ../aggregation_tool.cwl
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
      - id: std_out
      - id: std_err
