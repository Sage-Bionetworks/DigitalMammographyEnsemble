#!/usr/bin/env cwl-runner
#
# This tool checks that aggregator works correctly
#
cwlVersion: v1.0
class: CommandLineTool
baseCommand: /workdir/test/aggregation_tool_checker.py
arguments:
  - valueFrom: $(inputs.predictions_actual)
    prefix: -pa
  - valueFrom: $(inputs.predictions_exams_actual)
    prefix: -ea
  - valueFrom: $(inputs.predictions_expected)
    prefix: -pe
  - valueFrom: $(inputs.predictions_exams_expected)
    prefix: -ee

stdout: stdout.txt
stderr: stderr.txt

inputs:
  - id: predictions_actual
    type: File
  - id: predictions_exams_actual
    type: File
  - id: predictions_expected
    type: File
  - id: predictions_exams_expected
    type: File
      
outputs:
  - id: std_out
    type: File
    outputBinding:
      glob: stdout.txt
  - id: std_err
    type: File
    outputBinding:
      glob: stderr.txt
