#!/usr/bin/env cwl-runner
#
# This tool aggregrates results
#
cwlVersion: v1.0
class: CommandLineTool
baseCommand: /workdir/dummy_aggregation.py
arguments:
  - valueFrom: $(inputs.models)
    prefix: -m
  - valueFrom: $(inputs.predictions)
    prefix: -p
  - valueFrom: $(inputs.predictions_exams)
    prefix: -e
    
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


