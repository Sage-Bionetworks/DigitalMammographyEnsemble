#!/usr/bin/env cwl-runner
#
# This tool aggregrates results
#
cwlVersion: v1.0
class: CommandLineTool
baseCommand: /workdir/dummy_aggregation.py
arguments:
  - valueFrom: $(inputs.models)
    prefix: -i
  - valueFrom: $(inputs.predictions)
    prefix: -p
    
stdout: agg_out.txt


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
  - id: agg_out
    type: File
    outputBinding:
      glob: agg_out.txt


