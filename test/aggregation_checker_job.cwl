
executed_models:
  - name: model-1
    weight: 3.20175294864
    weight_r: 3.54181908505
    weight_re: 2.53026075011
    weight_e: 2.23417662743
  - name: model-2
    weight: 0
    weight_r: -1.6152435878
    weight_re: -0.775787160719
    weight_e: 0.652050951546

predictions:
  - class: File
    path: test_data/predictions/breast/model-1.tsv
  - class: File
    path: test_data/predictions/breast/model-2.tsv

predictions_exams:
  - class: File
    path: test_data/predictions/exam/model-1.tsv
  - class: File
    path: test_data/predictions/exam/model-2.tsv

precomputed_predictions:
  - name: model-3
    weight: 7.3933912108
    weight_r: 7.51608186079
    weight_re: 4.12406869782
    weight_e: 2.75189801926
    predictions: 
      class: File
      path: test_data/predictions/breast/model-3.tsv
    predictions_exams: 
      class: File
      path: test_data/predictions/exam/model-3.tsv
  - name: model-4
    weight: 4.08742449223
    weight_r: 1.22650962824
    weight_re: 3.23575153593
    weight_e: 4.28514789966
    predictions: 
      class: File
      path: test_data/predictions/breast/model-4.tsv
    predictions_exams: 
      class: File
      path: test_data/predictions/exam/model-4.tsv

 
intercept:
  weight: -9.760418753
  weight_r: -9.04168517207
  weight_re: -9.91406107949
  weight_e: -9.39316702699

predictions_expected:
  class: File
  path:  test_data/expected_breast.tsv
predictions_exams_expected:
  class: File
  path: test_data/expected_exam.tsv
 
   