
executed_models:
  - name: submission-9650054
    weight: 3.20175294864
    weight_r: 3.54181908505
    weight_re: 2.53026075011
    weight_e: 2.23417662743
  - name: submission-9650055
    weight: 0
    weight_r: -1.6152435878
    weight_re: -0.775787160719
    weight_e: 0.652050951546
  - name: submission-9646823
    weight: 4.22646910725
    weight_r: 3.42699226827
    weight_re: 3.19941853197
    weight_e: 3.54244847843
  - name: submission-9648889
    weight: -5.97362329895
    weight_r: -5.24856331514
    weight_re: 0.289826558944
    weight_e: 0.445300980695
  - name: submission-9648888
    weight: -0.417575104153
    weight_r: -1.1773951327
    weight_re: -4.02983495168
    weight_e: -2.77049159808

predictions:
  - class: File
    path: predictions/breast/9650054.tsv
  - class: File
    path: predictions/breast/9650055.tsv
  - class: File
    path: predictions/breast/9646823.tsv
  - class: File
    path: predictions/breast/9648889.tsv
  - class: File
    path: predictions/breast/9648888.tsv

predictions_exams:
  - class: File
    path: predictions/exam/9650054.tsv
  - class: File
    path: predictions/exam/9650055.tsv
  - class: File
    path: predictions/exam/9646823.tsv
  - class: File
    path: predictions/exam/9648889.tsv
  - class: File
    path: predictions/exam/9648888.tsv

precomputed_predictions:
  - name: submission-9648917
    weight: 7.3933912108
    weight_r: 7.51608186079
    weight_re: 4.12406869782
    weight_e: 2.75189801926
    predictions: 
      class: File
      path: predictions/breast/9648917.tsv
    predictions_exams: 
      class: File
      path: predictions/exam/9648917.tsv
  - name: submission-9648211
    weight: 4.08742449223
    weight_r: 1.22650962824
    weight_re: 3.23575153593
    weight_e: 4.28514789966
    predictions: 
      class: File
      path: predictions/breast/9648211.tsv
    predictions_exams: 
      class: File
      path: predictions/exam/9648211.tsv
  - name: submission-9648881
    weight: 0.86594754016
    weight_r: 1.00753744717
    weight_re: 0.990813201089
    weight_e: 0.831391586046
    predictions: 
      class: File
      path: predictions/breast/9648881.tsv
    predictions_exams: 
      class: File
      path: predictions/exam/9648881.tsv
  - name: submission-9650232
    weight: -2.78041860641
    weight_r: -1.86531550913
    weight_re: -1.41969989262
    weight_e: -1.81844942551
    predictions: 
      class: File
      path: predictions/breast/9650232.tsv
    predictions_exams: 
      class: File
      path: predictions/exam/9650232.tsv
  - name: submission-9650290
    weight: -8.3886610187
    weight_r: -8.93072331183
    weight_re: -6.74239278823
    weight_e: -6.17837633658
    predictions: 
      class: File
      path: predictions/breast/9650290.tsv
    predictions_exams: 
      class: File
      path: predictions/exam/9650290.tsv
  - name: submission-9650300
    weight: 11.2793931657
    weight_r: 10.8800207499
    weight_re: 8.67925172025
    weight_e: 8.8835717166
    predictions: 
      class: File
      path: predictions/breast/9650300.tsv
    predictions_exams: 
      class: File
      path: predictions/exam/9650300.tsv
 
intercept:
  weight: -9.760418753
  weight_r: -9.04168517207
  weight_re: -9.91406107949
  weight_e: -9.39316702699

predictions_expected:
  class: File
  path:  /workdir/GH_validation_breast.csv
predictions_exams_expected:
  class: File
  path: /workdir/GH_validation_exam.csv
 
   