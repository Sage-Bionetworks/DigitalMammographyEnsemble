#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: CommandLineTool
baseCommand: docker
arguments: [run,
 -i,
 --env="GPUS=$(inputs.first_gpu_device);$(inputs.second_gpu_device)",
 --env="NUM_GPU_DEVICES=2",
 --env="NUM_CPU_CORES=15",
 --env="MEMORY_GB=200",
 --env="RANDOM_SEED=12345",
 --env="WALLTIME_MINUTES=20160",
 --volume-driver=nvidia-docker,
 --volume=$(inputs.images_data_folder):/inferenceData:ro,
 --volume=$(inputs.images_crosswalk_tsv):/metadata/images_crosswalk.tsv:ro,
 --volume=$(inputs.exams_metadata):/metadata/exams_metadata.tsv:ro,
 --volume=$(inputs.output_folder)/predictions.tsv:/output/predictions.tsv:rw,
 --volume=$(inputs.scratch_folder):/scratch:rw,
 --volume=nvidia_driver_384.59:/usr/local/nvidia:ro,
 --device=/dev/nvidiactl:/dev/nvidiactl:rw,
 --device=/dev/nvidia-uvm:/dev/nvidia-uvm:rw,
 --device=$(inputs.first_gpu_device):$(inputs.first_gpu_device):rw,
 --device=$(inputs.second_gpu_device):$(inputs.second_gpu_device):rw,
 --log-opt, max-file=2,
 --log-opt, max-size=1g,
 --cpuset-cpus, $(inputs.cpu_set),
 --memory, 200g,
 --memory-swap, 0m,
 --net=none,
 --name=$(inputs.docker_container_name),
 $(inputs.docker_image_reference),
 $(inputs.entry_point)]


requirements:
  InitialWorkDirRequirement:
    listing:
      - entryname: .docker/config.json
        entry: |
          {"auths": {"$(inputs.docker_registry)": {"auth": "$(inputs.docker_registry_auth)"}}}

inputs:
  images_data_folder:
    type: string
  images_crosswalk_tsv:
    type: string
  scratch_folder:
    type: string
  output_folder:
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

# TODO let Toil set up the output folder
outputs:
  inferences:
    type: File
    outputBinding:
      glob: $(inputs.output_folder)/predictions.tsv

