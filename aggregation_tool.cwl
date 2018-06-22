#!/usr/bin/env cwl-runner
#
# This tool aggregrates results
#
cwlVersion: v1.0
class: CommandLineTool
baseCommand: /workdir/aggregation.py
arguments:
  - valueFrom: $(inputs.executed_models)
    prefix: -m
  - valueFrom: $(inputs.predictions)
    prefix: -p
  - valueFrom: $(inputs.predictions_exams)
    prefix: -e
  - valueFrom: $(inputs.precomputed_predictions)
    prefix: -q
  - prefix: -i
    valueFrom: $(inputs.intercept.weight)
  - prefix: -ir
    valueFrom: $(inputs.intercept.weight_r)
  - prefix: -ire
    valueFrom: $(inputs.intercept.weight_re)
  - prefix: -ie
    valueFrom: $(inputs.intercept.weight_e)


    
stdout: aggregation_out.txt
stderr: aggregation_err.txt

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
      
outputs:
  - id: ensemble_predictions
    type: File
    outputBinding:
      glob: ensemble_predictions.tsv
  - id: ensemble_predictions_exams
    type: File
    outputBinding:
      glob: ensemble_predictions_exams.tsv
  - id: std_out
    type: File
    outputBinding:
      glob: aggregation_out.txt
  - id: std_err
    type: File
    outputBinding:
      glob: aggregation_err.txt

