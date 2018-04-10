#!/usr/bin/env cwl-runner
#
# This tool aggregrates results
#
cwlVersion: v1.0
class: CommandLineTool
baseCommand: [python, aggregate.py]
inputs:
  value:
    type: File[]
    inputBinding:
      position: 1

outputs:
  agg_out: stdout

#TODO here is where we link in Eren's code
requirements:
  InitialWorkDirRequirement:
    listing:
      - entryname: aggregate.py
        entry: |
          import sys
          import json
          total=0
          for infile in sys.argv[1:]:
            with open(infile, 'r') as content_file:
              content = content_file.read()
              total = total + float(content)
          print(total)

