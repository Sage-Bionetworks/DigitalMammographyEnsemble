executed-models:
  - name: sub-9650054
    weight: 3.20175294864353
    weight_r: 3.5418190850458
    weight_re: 2.5302607501146
    weight_e: 2.23417662742951
  - name: sub-9650055
    weight: .22646910724525
    weight_r: 3.42699226826791
    weight_re: 0.289826558943993
    weight_e: 0.445300980694737
  - name: sub-9646823
    weight: -9.76041875300229
    weight_r: -9.04168517207305
    weight_re: -9.91406107949106
    weight_e: -9.39316702698657
    
predictions:
  - class: File
    path: ../predictions/breast/9650054.tsv
  - class: File
    path: ../predictions/breast/9650055.tsv
  - class: File
    path: ../predictions/breast/9646823.tsv
 
predictions_exams:
  - class: File
    path: ../predictions/exam/9650054.tsv
  - class: File
    path: ../predictions/exam/9650055.tsv
  - class: File
    path: ../predictions/exam/9646823.tsv

precomputed_predictions:
  - name: sub-9646823
    weight: 3.20175294864353
    weight_r: 3.5418190850458
    weight_re: 2.5302607501146
    weight_e: 2.23417662742951
    predictions: 
      - class: File
      - path: ../predictions/breast/9646823.tsv
    predictions_exams: 
      - class: File
      - path: ../predictions/exam/9646823.tsv
  - name: sub-9648211
    weight: 3.20175294864353
    weight_r: 3.5418190850458
    weight_re: 2.5302607501146
    weight_e: 2.23417662742951
    predictions:  
      - class: File
      - path: ../predictions/breast/9648211.tsv
    predictions_exams:
      - class: File
      - path: ../predictions/exam/9648211.tsv
    
intercept:
  weight: -9.760418753
  weight_r: -9.04168517207
  weight_re: -9.91406107949
  weight_e: -9.39316702699
   
    
    