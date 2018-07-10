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
    parser.add_argument("-m","--models", required=False, nargs="*", help="models")
    parser.add_argument("-p","--predictions", required=False, nargs="*", help="predictions")
    parser.add_argument("-e","--predictions_exams", required=False, nargs="*", help="predictions-exams")
    parser.add_argument("-q","--precomputed-predictions", required=False, nargs="*", help="precomputed-predictions")
    parser.add_argument("-i","--intercept_weight", required=True, help="intercept_weight")
    parser.add_argument("-ir","--intercept_weight_r", required=True, help="intercept_weight_r")
    parser.add_argument("-ire","--intercept_weight_re", required=True, help="intercept_weight_re")
    parser.add_argument("-ie","--intercept_weight_e", required=True, help="intercept_weight_e")
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

    for ppString in args.precomputed_predictions:
        pp = eval(ppString)
        d = {}
        d['name']=pp['name']
        d['weight']=pp['weight']
        d['weight_r']=pp['weight_r']
        d['weight_re']=pp['weight_re']
        d['weight_e']=pp['weight_e']
        d['predictions']=pp['predictions']['path']
        d['predictions_exams']=pp['predictions_exams']['path']
        merged_inputs.append(d)
        
    merged_inputs.append({'name':'intercept', 
                       'weight':args.intercept_weight,
                       'weight_r':args.intercept_weight_r,
                       'weight_re':args.intercept_weight_re,
                       'weight_e':args.intercept_weight_e
                       })

    model_names=[]
    weights = []
    for d in merged_inputs:
        modelName=d['name']
        modelWeight=float(d['weight'])
        weights.append(modelWeight)
        model_names.append(modelName)

    weight_matrix=pd.DataFrame(weights,index=model_names)
    # Exam level
    weights = []
    for d in merged_inputs:
        modelWeight=float(d['weight_e'])
        weights.append(modelWeight)
    weight_matrixExam=pd.DataFrame(weights,index=model_names)
    
    ## Get for with radiologist
    weights = []
    for d in merged_inputs:
        modelWeight=float(d['weight_r'])
        weights.append(modelWeight)
    weight_matrix_r=pd.DataFrame(weights,index=model_names)

    ## Get for with radiologist exam
    weights = []
    for d in merged_inputs:
        modelWeight=float(d['weight_re'])
        weights.append(modelWeight)
    weight_matrix_rExam=pd.DataFrame(weights,index=model_names)

    ## Get a dataframe for model weights
    # set index to model_names

    predictionExamsContent = read_tsv(merged_inputs[0]['predictions_exams'])
    predictionExamsContent.rename(columns={'confidence':model_names[0]},inplace=True)
    i=1
    for mi in merged_inputs[1:]:
        if model_names[i] != mi['name']:
            raise Exception("Expected "+model_names[i]+" but found "+mi['name'])
        if (mi['name']!='intercept'):
            prediction_exam = mi['predictions_exams']
            exam=read_tsv(prediction_exam)
            predictionExamsContent[model_names[i]]=exam.iloc[:,1]
        i=i+1
    # Add a dummy column for intercept
    predictionExamsContent["intercept"]=1
    ## Next get breast level data frame

    predictionContent = read_tsv(merged_inputs[0]['predictions'])
    predictionContent.rename(columns={'confidence':model_names[0]},inplace=True)
    i=1
    for mi in merged_inputs[1:]:
        if model_names[i] != mi['name']:
            raise Exception("Expected "+model_names[i]+" but found "+mi['name'])
        if (mi['name']!='intercept'):
            prediction = mi['predictions']
            exam=read_tsv(prediction)
            predictionContent[model_names[i]]=exam.iloc[:,2]
        i=i+1
    predictionContent["intercept"]=float(1)
    ### Calculate confidence This depends if radiologist exists or not
    if 'radiologist' in model_names:
        print "predictions include radiologist"
        confidence_ensemble=predictionContent[model_names].dot(weight_matrix_r)
        confidence_ensembleExam=predictionExamsContent[model_names].dot(weight_matrix_rExam)
    # If radiolgist is not among given methods
    if 'radiologist' not in model_names:
        print "predictions do not include radiologist"
        confidence_ensemble=predictionContent[model_names].dot(weight_matrix)
        confidence_ensembleExam=predictionExamsContent[model_names].dot(weight_matrixExam)
    predictionContent["ensemble"]=1-1/(1+np.exp(confidence_ensemble))
    predictionExamsContent["ensemble"]=1-1/(1+np.exp(confidence_ensembleExam))
    predictionExamsContent.drop(columns="intercept")
    predictionContent.drop(columns="intercept")
    print ('%.18f' % (1-1/(1+np.exp(confidence_ensembleExam.iloc[0,:]))))
    result=predictionContent[['subjectId', 'laterality', 'ensemble']].rename(columns={'ensemble':'confidence'})
    result.to_csv('ensemble_predictions.tsv',sep="\t",index=False)
    resultExams=predictionExamsContent[['subjectId', 'ensemble']].rename(columns={'ensemble':'confidence'})
    resultExams.to_csv('ensemble_predictions_exams.tsv',sep="\t",index=False)

