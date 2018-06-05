#!/usr/bin/env python
# this code verifies that the inputs are present
# then creates two files, predictions.tsv, precictions_exams.tsv

import csv
import argparse

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
    parser = argparse.ArgumentParser()
    parser.add_argument("-i","--images_crosswalk", required=True, help="images crosswalk file")
    parser.add_argument("-e","--exams_metadata", required=True, help="exams metadata file")
    parser.add_argument("-v","--value", required=True, help="some parameter")
    args = parser.parse_args()
    imagesSubjectIds = getSubjectIds(args.images_crosswalk)
    examsSubjectIds = getSubjectIds(args.exams_metadata)
    if imagesSubjectIds!=examsSubjectIds:
        raise Exception("Image crosswalk subject IDs: "+str(imagesSubjectIds)+", but exams metadata subject Ids: "+str(examsSubjectIds))
    
    with open('predictions.tsv', 'wb') as csvout:
        csvwriter = csv.writer(csvout, delimiter="\t")
        csvwriter.writerow(['subjectId','laterality','confidence'])
        for subjectId in imagesSubjectIds:
            for laterality in ['L', 'R']:
                csvwriter.writerow([subjectId, laterality, args.value])

    with open('predictions_exams.tsv', 'wb') as csvout:
        csvwriter = csv.writer(csvout, delimiter="\t")
        csvwriter.writerow(['subjectId','confidence'])
        for subjectId in examsSubjectIds:
            csvwriter.writerow([subjectId, args.value])
                