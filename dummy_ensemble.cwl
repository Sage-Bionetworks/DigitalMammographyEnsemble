#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: Workflow


inputs:
  model:
    type:
      type: array
      items:
        type: record
        fields:
          - name: name
            type: string
          - name: weight
            type: float
          
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
    run: dm_dummy_inference.cwl
    scatter: model
    in:
      images_crosswalk_tsv: 
        valueFrom: '/workdir/SC2_single_subject_images_crosswalk.tsv'
      exams_metadata: 
        valueFrom: '/workdir/SC2_single_subject_exams_metadata.tsv'
      model: 
        source: "#model"
    out:
      - id: predictions
      - id: predictions_exams

  aggregate:
    run:  dummy_aggregation_tool.cwl
    in:
      - id: models
        source: "#model"
      - id: predictions
        source: "#inference/predictions"
      - id: predictions_exams
        source: "#inference/predictions_exams"
    out:
      - id: ensemble_predictions
      - id: ensemble_predictions_exams

