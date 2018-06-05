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
  result:
    type: File
    outputSource: aggregate/agg_out

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
    out: [predictions, predictions_exams]

  aggregate:
    run:  aggregation_tool.cwl
    in:
      value: inference/predictions
    out: [agg_out]