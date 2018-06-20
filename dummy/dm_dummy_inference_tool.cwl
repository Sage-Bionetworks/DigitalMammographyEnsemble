#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: CommandLineTool
baseCommand: /workdir/dummy/simple_model.py
arguments:
  - valueFrom: $(inputs.images_crosswalk_tsv)
    prefix: -i
  - valueFrom: $(inputs.exams_metadata)
    prefix: -e
  - valueFrom: $(inputs.model.weight)
    prefix: -v

inputs:
  images_crosswalk_tsv:
    type: string
  exams_metadata:
    type: string
  model:
    type:
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

outputs:
  - id: predictions
    type: File
    outputBinding:
      glob: predictions.tsv
  - id: predictions_exams
    type: File
    outputBinding:
      glob: predictions_exams.tsv
