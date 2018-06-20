#!/usr/bin/env python
import sys
import json
import csv
import argparse
from ruamel.ordereddict import ordereddict

def read_tsv(filepath):
    result = []
    with open(filepath,'rb') as tsvin:
        tsvin = csv.reader(tsvin, delimiter='\t')
    
        for row in tsvin:
            result.append(row)
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
    print "\n".join(sys.argv)
    parser = argparse.ArgumentParser()
    parser.add_argument("-m","--models", required=True, nargs="+", help="models")
    parser.add_argument("-p","--predictions", required=True, nargs="+", help="predictions")
    parser.add_argument("-e","--predictions_exams", required=True, nargs="+", help="predictions-exams")
    args = parser.parse_args()

    print("\n--Models:--")
    weights = []
    for model in args.models:
        d=eval(model)
        modelName=d['name']
        modelWeight=d['weight']
        print('Model Name: '+modelName+', weight: '+str(modelWeight))
        weights.append(modelWeight)
        
    print("\n--predictions:--")
    predictionContent = []
    for prediction in args.predictions:
        print(prediction)
        predictionContent.append(read_tsv(prediction))

    predictionExamsContent = []
    print("\n--predictions-exams:--")
    for prediction_exam in args.predictions_exams:
        print(prediction_exam)
        predictionExamsContent.append(read_tsv(prediction_exam))

    # now product the output
    imagesSubjectIds = getSubjectIds(args.predictions[0])
    examsSubjectIds = getSubjectIds(args.predictions_exams[0])
    if imagesSubjectIds!=examsSubjectIds:
        raise Exception("Image crosswalk subject IDs: "+str(imagesSubjectIds)+", but exams metadata subject Ids: "+str(examsSubjectIds))

    with open('ensemble_predictions.tsv', 'wb') as csvout:
        csvwriter = csv.writer(csvout, delimiter="\t")
        csvwriter.writerow(['subjectId','laterality','confidence'])
        for subjectId in imagesSubjectIds:
            for laterality in ['L', 'R']:
                csvwriter.writerow([subjectId, laterality, 0])

    with open('ensemble_predictions_exams.tsv', 'wb') as csvout:
        csvwriter = csv.writer(csvout, delimiter="\t")
        csvwriter.writerow(['subjectId','confidence'])
        for subjectId in examsSubjectIds:
            csvwriter.writerow([subjectId, 0])
    
