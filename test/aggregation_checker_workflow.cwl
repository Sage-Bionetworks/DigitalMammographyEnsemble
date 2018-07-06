#!/usr/bin/env cwl-runner
#
# this workflow runs the aggregation tool and verifies the output
#
cwlVersion: v1.0
class: Workflow

inputs:
  - id: executed_models
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
  - id: predictions
    type:
      type: array
      items: File
  - id: predictions_exams
    type:
      type: array
      items: File
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
  - id: predictions_expected
    type: File
  - id: predictions_exams_expected
    type: File

outputs:
  - id: std_out
    type: File
    outputSource: check/std_out
  - id: std_err
    type: File
    outputSource: check/std_err

steps:
  aggregation:
    run: aggregation_tool.cwl
    in:
      - id: executed_models
        source: "#executed_models"
      - id: predictions
        source: "#predictions"
      - id: predictions_exams
        source: "#predictions_exams"
      - id: precomputed_predictions
        source: "#precomputed_predictions"
      - id: intercept
        source: "#intercept"
    out:
      - id: ensemble_predictions
      - id: ensemble_predictions_exams
  check:
    run: aggregation_tool_checker.cwl
    in:
      - id: predictions_actual
        source: "#aggregation/ensemble_predictions"
      - id: predictions_exams_actual
        source: "#aggregation/ensemble_predictions_exams"
      - id: predictions_expected
        source: "#predictions_expected"
      - id: predictions_exams_expected
        source: "#predictions_exams_expected"
    out:
      - id: std_out
      - id: std_err
