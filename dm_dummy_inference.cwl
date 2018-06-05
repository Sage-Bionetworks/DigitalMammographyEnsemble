#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: CommandLineTool
baseCommand: /workdir/simple_model.py
arguments:

  - valueFrom: $(inputs.images_crosswalk_tsv)
    prefix: -i
  - valueFrom: $(inputs.exams_metadata)
    prefix: -e
  - valueFrom: $(inputs.value)
    prefix: -v

inputs:
  images_crosswalk_tsv:
    type: string
  exams_metadata:
    type: string
  value:
    type: float

outputs:
  predictions:
    type: File
    outputBinding:
      glob: predictions.tsv
  predictions_exams:
    type: File
    outputBinding:
      glob: predictions_exams.tsv
