images_crosswalk_tsv: /workdir/dummy/SC2_single_subject_images_crosswalk.tsv
exams_metadata: /workdir/dummy/SC2_single_subject_exams_metadata.tsv

models-to-run:
  - name: sub-9650054
    weight: 3.20175294864353
    weight_r: 3.5418190850458
    weight_re: 2.5302607501146
    weight_e: 2.23417662742951
    docker_reference: foo
  - name: sub-9650055
    weight: .22646910724525
    weight_r: 3.42699226826791
    weight_re: 0.289826558943993
    weight_e: 0.445300980694737
    docker_reference: foo
  - name: sub-9646823
    weight: -9.76041875300229
    weight_r: -9.04168517207305
    weight_re: -9.91406107949106
    weight_e: -9.39316702698657
    docker_reference: foo

precomputed-predictions:
  - name: sub-965005A
    weight: 3.20175294864353
    weight_r: 3.5418190850458
    weight_re: 2.5302607501146
    weight_e: 2.23417662742951
    predictions: path/to/fooA
    predictions_exams: path/to/barA
  - name: sub-965005B
    weight: 3.20175294864353
    weight_r: 3.5418190850458
    weight_re: 2.5302607501146
    weight_e: 2.23417662742951
    predictions: path/to/fooB
    predictions_exams: path/to/barB
    
intercept:
  weight: -9.760418753
  weight_r: -9.04168517207
  weight_re: -9.91406107949
  weight_e: -9.39316702699
   
    
    