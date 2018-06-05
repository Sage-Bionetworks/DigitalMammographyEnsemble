#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: CommandLineTool
baseCommand: docker
arguments: 
  - valueFrom: run
  - valueFrom: -i
  - valueFrom: --env="GPUS=$(inputs.first_gpu_device);$(inputs.second_gpu_device)"
  - valueFrom: --env="NUM_GPU_DEVICES=2"
  - valueFrom: --env="NUM_CPU_CORES=15"
  - valueFrom: --env="MEMORY_GB=200"
  - valueFrom: --env="RANDOM_SEED=12345"
  - valueFrom: --env="WALLTIME_MINUTES=20160"
  - valueFrom: --volume-driver=nvidia-docker
  - valueFrom: --volume=$(inputs.images_data_folder):/inferenceData:ro
  - valueFrom: --volume=$(inputs.images_crosswalk_tsv):/metadata/images_crosswalk.tsv:ro
  - valueFrom: --volume=$(inputs.exams_metadata):/metadata/exams_metadata.tsv:ro
  - valueFrom: --volume=$(inputs.host_workdir)/$((runtime.outdir).split('/').slice(-1)[0]):/output:rw
  - valueFrom: --volume=$(inputs.scratch_folder):/scratch:rw
  - valueFrom: --volume=nvidia_driver_396.26:/usr/local/nvidia:ro
  - valueFrom: --device=/dev/nvidiactl:/dev/nvidiactl:rw
  - valueFrom: --device=/dev/nvidia-uvm:/dev/nvidia-uvm:rw
  - valueFrom: --device=/dev/nvidia-uvm-tools:/dev/nvidia-uvm-tools:rw
  - valueFrom: --device=$(inputs.first_gpu_device):$(inputs.first_gpu_device):rw
  - valueFrom: --device=$(inputs.second_gpu_device):$(inputs.second_gpu_device):rw
  - valueFrom: --log-opt
  - valueFrom: max-file=2
  - valueFrom: --log-opt
  - valueFrom: max-size=1g
  - valueFrom: --cpuset-cpus
  - valueFrom: $(inputs.cpu_set)
  - valueFrom: --memory
  - valueFrom: 200g
  - valueFrom: --memory-swap
  - valueFrom: 0m
  - valueFrom: --net=none
  - valueFrom: --name=$(inputs.docker_container_name)
  - valueFrom:  $(inputs.docker_image_reference)
  - valueFrom:  $(inputs.entry_point)

requirements:
  - class: InitialWorkDirRequirement
    listing:
      - entryname: .docker/config.json
        entry: |
          {"auths": {"$(inputs.docker_registry)": {"auth": "$(inputs.docker_registry_auth)"}}}
  - class: InlineJavascriptRequirement

inputs:
  images_data_folder:
    type: string
  images_crosswalk_tsv:
    type: string
  exams_metadata:
    type: string
  scratch_folder:
    type: string
  cpu_set:
    type: string
  first_gpu_device:
    type: string
  second_gpu_device:
    type: string
  docker_image_reference:
    type: string
  docker_container_name:
    type: string
  docker_registry:
    type: string
  docker_registry_auth:
    type: string
  host_workdir:
    type: string

outputs:
  predictions:
    type: File
    outputBinding:
      glob: predictions.tsv
  predictions_exams:
    type: File
    outputBinding:
      glob: predictions_exams.tsv
