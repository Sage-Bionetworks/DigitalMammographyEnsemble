# These are paths on the host machine
images_data_folder: 
images_crosswalk_tsv: 
exams_metadata: 
scratch_folder: 
host_workdir:

entry_point: /sc2_infer.sh

docker_image_reference: docker.synapse.org/syn7887972/9650260/scoring@sha256:a8f660e2b33e0759cb679e2dcfab53ab51120eeec8e16b1d2a29060812d024b7

docker_registry: docker.synapse.org
docker_registry_auth: 

docker_container_name: cwl-sc2

first_gpu_device: /dev/nvidia0

second_gpu_device: /dev/nvidia1

cpu_set: 1-15
