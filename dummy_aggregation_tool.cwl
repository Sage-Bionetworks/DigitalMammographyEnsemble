#!/usr/bin/env cwl-runner
#
# This tool aggregrates results
#
cwlVersion: v1.0
class: CommandLineTool
baseCommand: dummy_aggregation.py
arguments:
  - valueFrom: $(inputs.models)
    prefix: -i
  - valueFrom: $(inputs.predictions)
    prefix: -p
    
stdout: agg_out.txt


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
    predictions:
      type:
        type: array
        items:
          type: File

outputs:
  - id: agg_out
    type: File
    outputBinding:
      glob: agg_out.txt


