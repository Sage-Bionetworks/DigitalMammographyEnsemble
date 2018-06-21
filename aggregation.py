#!/usr/bin/env python
import sys
import json
import csv
import argparse
from ruamel.ordereddict import ordereddict
import pandas as pd
import numpy as np

def read_tsv(filepath):
    result = pd.read_table(filepath,header=0)
    return result

def getSubjectIds(filepath):
    content=read_tsv(filepath)
    if not content[0][0]=='subjectId':
        raise Exception("Expected 'subjectId' in first col but found "+content[0][0])
    result = set()
    for row in content:
        if row[0]!='subjectId':
            result.add(row[0])
    return result

if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument("-m","--models", required=False, nargs="+", help="models")
    parser.add_argument("-p","--predictions", required=False, nargs="+", help="predictions")
    parser.add_argument("-e","--predictions_exams", required=False, nargs="+", help="predictions-exams")
    parser.add_argument("-q","--precomputed-predictions", required=False, nargs="+", help="precomputed-predictions")
    parser.add_argument("-i","--intercept", required=True, help="intercept")
    args = parser.parse_args()
    
    n = len(args.models)
    if len(args.predictions) != n:
        raise Exception('models has length '+str(n)+' but predictions has length '+str(len(args.predictions)))
    if len(args.predictions_exams) != n:
        raise Exception('models has length '+str(n)+' but predictions_exams has length '+str(len(args.predictions_exams)))

    # combine results for models that were run with results for precomputed models
    merged_inputs = []
    for i in range(n):
        d=eval(args.models[i])
        d['predictions']=args.predictions[i]
        d['predictions_exams']=args.predictions_exams[i]
        merged_inputs.append(d)

    for pp in args.precomputed_predictions:
        merged_inputs.append(eval(pp))
        
    intercept = eval(args.intercept)
    if len(intercept)!=4:
        raise Exception("Excpeted four values for intercept but found "+str(intercept))
    merged_inputs.append({'name':'intercept', 
                       'weight':intercept['weight'],
                       'weight_r':intercept['weight_r'],
                       'weight_re':intercept['weight_re'],
                       'weight_e':intercept['weight_e']
                       })

    model_names=[]
    weights = []
    for d in merged_inputs:
        modelName=d['name']
        modelWeight=d['weight']
        weights.append(modelWeight)
        model_names.append(modelName)

    weight_matrix=pd.DataFrame(weights,index=model_names)
    # Exam level
    weights = []
    for d in merged_inputs:
        modelWeight=d['weight_e']
        weights.append(modelWeight)
    weight_matrixExam=pd.DataFrame(weights,index=model_names)
    
    ## Get for with radiologist
    weights = []
    for d in merged_inputs:
        modelWeight=d['weight_r']
        weights.append(modelWeight)
    weight_matrix_r=pd.DataFrame(weights,index=model_names)

    ## Get for with radiologist exam
    weights = []
    for d in merged_inputs:
        modelWeight=d['weight_re']
        weights.append(modelWeight)
    weight_matrix_rExam=pd.DataFrame(weights,index=model_names)


    print("eren")
    ## Get a dataframe for model weights
    # set index to model_names


    predictionExamsContent = read_tsv(args.predictions_exams[0])
    predictionExamsContent.rename(columns={'confidence':model_names[0]},inplace=True)
    print("\n--predictions-exams:--")
    i=1
    for prediction_exam in args.predictions_exams[1:]:
        print(prediction_exam)
        exam=read_tsv(prediction_exam)
        predictionExamsContent[model_names[i]]=exam.iloc[:,1]
        i=i+1
    # Add a dummy column for intercept
    predictionExamsContent["intercept"]=1
    ## Next get breast level data frame

    predictionContent = read_tsv(args.predictions[0])
    predictionContent.rename(columns={'confidence':model_names[0]},inplace=True)
    print("\n--predictions-breast:--")
    i=1
    for prediction in args.predictions[1:]:
        exam=read_tsv(prediction)
        predictionContent[model_names[i]]=exam.iloc[:,2]
        i=i+1
    predictionContent["intercept"]=1
    ### Calculate confidence This depends if radiologist exists or not
    if 'radiologist' in model_names:
        print "predictions include radiologist"
        confidence_ensemble=predictionContent[model_names].dot(weight_matrix_r)
        confidence_ensembleExam=predictionExamsContent[model_names].dot(weight_matrix_rExam)
        predictionContent["ensemble"]=1-1/(1+np.exp(confidence_ensemble))
        predictionExamsContent["ensemble"]=1-1/(1+np.exp(confidence_ensembleExam))
        predictionExamsContent.drop(columns="intercept")
        predictionContent.drop(columns="intercept")
        predictionContent.to_csv('ensemble_predictions.tsv',sep="\t",index=False)
        predictionExamsContent.to_csv('ensemble_predictions_exams.tsv',sep="\t",index=False)
        print ('%.18f' % (1-1/(1+np.exp(confidence_ensembleExam.iloc[0,:]))))
    # If radiolgist is not among given methods
    if 'radiologist' not in model_names:
        print "predictions does not include radiologist"
        confidence_ensemble=predictionContent[model_names].dot(weight_matrix)
        confidence_ensembleExam=predictionExamsContent[model_names].dot(weight_matrixExam)
        predictionContent["ensemble"]=1-1/(1+np.exp(confidence_ensemble))
        predictionExamsContent["ensemble"]=1-1/(1+np.exp(confidence_ensembleExam))
        predictionExamsContent.drop(columns="intercept")
        predictionContent.drop(columns="intercept")
        predictionContent.to_csv('ensemble_predictions.tsv',sep="\t",index=False)
        predictionExamsContent.to_csv('ensemble_predictions_exams.tsv',sep="\t",index=False)
        print ('%.18f' % (1-1/(1+np.exp(confidence_ensembleExam.iloc[0,:]))))


    # now product the output
    #imagesSubjectIds = getSubjectIds(args.predictions[0])
    #examsSubjectIds = getSubjectIds(args.predictions_exams[0])
    #if imagesSubjectIds!=examsSubjectIds:
    #    raise Exception("Image crosswalk subject IDs: "+str(imagesSubjectIds)+", but exams metadata subject Ids: "+str(examsSubjectIds))

    #with open('ensemble_predictions.tsv', 'wb') as csvout:
    #    csvwriter = csv.writer(csvout, delimiter="\t")
    #    csvwriter.writerow(['subjectId','laterality','confidence'])
    #    for subjectId in imagesSubjectIds:
    #        for laterality in ['L', 'R']:
    #            csvwriter.writerow([subjectId, laterality, 0])

    #with open('ensemble_predictions_exams.tsv', 'wb') as csvout:
    #    csvwriter = csv.writer(csvout, delimiter="\t")
    #    csvwriter.writerow(['subjectId','confidence'])
    #    for subjectId in examsSubjectIds:
    #        csvwriter.writerow([subjectId, 0])
