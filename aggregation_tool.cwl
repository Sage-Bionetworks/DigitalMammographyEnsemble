#!/usr/bin/env cwl-runner
#
# This tool aggregrates results
#
cwlVersion: v1.0
class: CommandLineTool
baseCommand: /workdir/aggregation.py
arguments:
  - valueFrom: $(inputs.models)
    prefix: -m
  - valueFrom: $(inputs.predictions)
    prefix: -p
  - valueFrom: $(inputs.predictions_exams)
    prefix: -e
    
stdout: aggregation_out.txt
stderr: aggregation_err.txt

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

  - id: predictions
    type:
      type: array
      items: File
  - id: predictions_exams
    type:
      type: array
      items: File

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

