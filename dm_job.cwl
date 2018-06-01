images_data_folder: /Users/bhoff/Documents/DigitalMammographyEnsemble/sc1/pilot_images

images_crosswalk_tsv: /Users/bhoff/Documents/DigitalMammographyEnsemble/sc1/images_crosswalk_pilot_20161118.tsv

scratch_folder: /Users/bhoff/Documents/DigitalMammographyEnsemble/sc1/scratch0/

output_folder: /Users/bhoff/Documents/DigitalMammographyEnsemble/sc1/inference0/

docker_image_reference: docker.synapse.org/syn7887972/9650260/scoring@sha256:a8f660e2b33e0759cb679e2dcfab53ab51120eeec8e16b1d2a29060812d024b7


docker_registry: docker.synapse.org
docker_registry_auth: ZG1jaGFsbGVuZ2VpdDpETUNoYWxsZW5nZTIwMTYhCg==

docker_container_name: cwl-sc1

first_gpu_device: /dev/nvidia0

second_gpu_device: /dev/nvidia1

cpu_set: 1-15
