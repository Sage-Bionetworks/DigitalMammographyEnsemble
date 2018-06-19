# These are paths on the host machine
images_data_folder: /data/data/dm_challenge_model_test_datasets/dcm/SC2_single_subject
images_crosswalk_tsv: /data/data/dm_challenge_model_test_datasets/metadata/SC2_single_subject_images_crosswalk.tsv
exams_metadata: /data/data/dm_challenge_model_test_datasets/metadata/SC2_single_subject_exams_metadata.tsv
scratch_folder: /data/scratch0
host_workdir: /home/dreamuser/DigitalMammographyEnsemble

entry_point: /sc2_infer.sh

docker_image_reference: docker.synapse.org/syn7887972/9650243/scoring@sha256:3ccbf3acf43d1e84c79028aa562e6f68cc6d20271a3b37b8168316d71ad44168

docker_registry: docker.synapse.org
docker_registry_auth: fill-in-base64-encoded-user-colon-password

docker_container_name: cwl-sc2

first_gpu_device: /dev/nvidia0

second_gpu_device: /dev/nvidia1

cpu_set: 1-15
