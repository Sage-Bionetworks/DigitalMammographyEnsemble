# These are paths on the host machine
images_data_folder: /data/data/dm_challenge_model_test_datasets/dcm/SC2_single_subject
images_crosswalk_tsv: /data/data/dm_challenge_model_test_datasets/metadata/SC2_single_subject_images_crosswalk.tsv
exams_metadata: /data/data/dm_challenge_model_test_datasets/metadata/SC2_single_subject_exams_metadata.tsv

models:
  - name: submission-9646823
    weight: 4.22646910725
    weight_r: 3.42699226827
    weight_re: 3.19941853197
    weight_e: 3.54244847843
    docker_reference: docker.synapse.org/syn7887972/9646823/scoring@sha256:1b228178417c03d30d1deec3339b933cf9bfb21850089073ec5cc47ea07e1591
  - name: submission-9648211
    weight: 4.08742449223
    weight_r: 1.22650962824
    weight_re: 3.23575153593
    weight_e: 4.28514789966
    docker_reference: docker.synapse.org/syn7887972/9648211/scoring@sha256:3aaeff5c2323455948c310188dbef5176683a247e8b3f4f63af1ee93b3f26e99
  - name: submission-9648881
    weight: 0.86594754016
    weight_r: 1.00753744717
    weight_re: 0.990813201089
    weight_e: 0.831391586046
    docker_reference: docker.synapse.org/syn7887972/9648881/scoring@sha256:efd7af7a4fd68841569117e16e1bb8aed0809a062870b15b8c858c7bdd47bbd0
  - name: submission-9648888
    weight: -0.417575104153
    weight_r: -1.1773951327
    weight_re: -4.02983495168
    weight_e: -2.77049159808
    docker_reference: docker.synapse.org/syn7887972/9648888/scoring@sha256:ea18c22f8753a4b55aad53f4c12e7fe5dee9d731596bc9653e4851e5d20d3fe8
  - name: submission-9648889
    weight: -5.97362329895
    weight_r: -5.24856331514
    weight_re: 0.289826558944
    weight_e: 0.445300980695
    docker_reference: docker.synapse.org/syn7887972/9648889/scoring@sha256:dd2199688e0d1a7f50944bf281673ac87462218b43a5a05e9c0e6cbbb536dac3
  - name: submission-9648917
    weight: 7.3933912108
    weight_r: 7.51608186079
    weight_re: 4.12406869782
    weight_e: 2.75189801926
    docker_reference: docker.synapse.org/syn7887972/9648917/scoring@sha256:32b532965d93eddd5925a016315b40bc320d34db97d6b5aa7f2dee7add455c02
  - name: submission-9650054
    weight: 3.20175294864
    weight_r: 3.54181908505
    weight_re: 2.53026075011
    weight_e: 2.23417662743
    docker_reference: docker.synapse.org/syn7887972/9650054/scoring@sha256:a8f660e2b33e0759cb679e2dcfab53ab51120eeec8e16b1d2a29060812d024b7
  - name: submission-9650055
    weight: 0
    weight_r: -1.6152435878
    weight_re: -0.775787160719
    weight_e: 0.652050951546
    docker_reference: docker.synapse.org/syn7887972/9650055/scoring@sha256:cd41685b8d6bb77883e4dec57d08b13710ecc5d67e00aeb5eca6734a0cdb0989
  - name: submission-9650232
    weight: -2.78041860641
    weight_r: -1.86531550913
    weight_re: -1.41969989262
    weight_e: -1.81844942551
    docker_reference: docker.synapse.org/syn7887972/9650232/scoring@sha256:cd41685b8d6bb77883e4dec57d08b13710ecc5d67e00aeb5eca6734a0cdb0989
  - name: submission-9650290
    weight: -8.3886610187
    weight_r: -8.93072331183
    weight_re: -6.74239278823
    weight_e: -6.17837633658
    docker_reference: docker.synapse.org/syn7887972/9650290/scoring@sha256:54b507796a6d6ff7385ad4d0c24770e54605e3e60a822e06c4ab9c91f5fa36fd
  - name: submission-9650300
    weight: 11.2793931657
    weight_r: 10.8800207499
    weight_re: 8.67925172025
    weight_e: 8.8835717166
    docker_reference: docker.synapse.org/syn7887972/9650300/scoring@sha256:725eb9c9942a3a4044aee31bc2b5045068ae3937984b1022fe0428c7e9b56cbf
   
precomputed_predictions: []

intercept:
  weight: -9.760418753
  weight_r: -9.04168517207
  weight_re: -9.91406107949
  weight_e: -9.39316702699
  