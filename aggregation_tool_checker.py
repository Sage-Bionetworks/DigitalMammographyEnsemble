#!/usr/bin/env python
import sys
import json
import csv
import argparse
from ruamel.ordereddict import ordereddict
import pandas as pd
import numpy as np
from pandas.util.testing import assert_frame_equal

def read_tsv(filepath):
    return pd.read_table(filepath,header=0)

def read_csv(filepath):
    return pd.read_csv(filepath,header=0)

# takes in the expected and actual predictions files and computes their difference
if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument("-pa","--predictions_actual", required=True, help="actual predictions")
    parser.add_argument("-ea","--predictions_exams_actual", required=True, help="actual exam-level predictions")
    parser.add_argument("-pe","--predictions_expected", required=True, help="expected predictions")
    parser.add_argument("-ee","--predictions_exams_expected", required=True, help="expected exam-level predictions")
    args = parser.parse_args()
    predictions_actual=read_tsv(args.predictions_actual)
    predictions_expected=read_csv(args.predictions_expected)
    print("columns in actual predictions: "+str(predictions_actual))
    print("columns in expected predictions: "+str(predictions_expected))
    assert_frame_equal(predictions_actual, predictions_expected)
    
    predictions_exams_actual=read_tsv(args.predictions_exams_actual)
    predictions_exams_expected=read_csv(args.predictions_exams_expected)
    print("columns in actual exams-level predictions: "+str(predictions_exams_actual))
    print("columns in expected exams-level predictions: "+str(predictions_exams_expected))

    assert_frame_equal(predictions_exams_actual, predictions_exams_expected)
