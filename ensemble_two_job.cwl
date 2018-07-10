# These are paths on the host machine
images_data_folder: /data/data/dm_challenge_model_test_datasets/dcm/SC2_single_subject
images_crosswalk_tsv: /data/data/dm_challenge_model_test_datasets/metadata/SC2_single_subject_images_crosswalk.tsv
exams_metadata: /data/data/dm_challenge_model_test_datasets/metadata/SC2_single_subject_exams_metadata.tsv

models:
  - name: submission-9650290
    weight: -8.3886610187
    weight_r: -8.93072331183
    weight_re: -6.74239278823
    weight_e: -6.17837633658
    docker_reference: docker.synapse.org/syn7887972/9650290/scoring
  - name: submission-9650300
    weight: 11.2793931657
    weight_r: 10.8800207499
    weight_re: 8.67925172025
    weight_e: 8.8835717166
    docker_reference: docker.synapse.org/syn7887972/9650300/scoring
   
precomputed_predictions: []

intercept:
  weight: -9.760418753
  weight_r: -9.04168517207
  weight_re: -9.91406107949
  weight_e: -9.39316702699
  