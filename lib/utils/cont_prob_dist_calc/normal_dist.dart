/**
 * Computes normal distribution and almost all of its related cases (probabilities and statistics).
 * 
 * Abbreviations:
 * 1. LT = Less than
 * 2. GT = Greater than
 */


import 'dart:core';
import 'package:normal/normal.dart';


class NormalDistribution {

  /// Function for computing all the possible cases (probabilities and statistics) of the distribution.
  static Map<String, String> getAllCasesOfNormalDist(
      double mean, double stdev, double x) {
    Map<String, String> probabilitiesMap = Map<String, String>();
    try {
      if (stdev < 0)
        throw Exception("Standard deviation should be >=0.");
      else {
        probabilitiesMap["LT"] = _normDistLT(mean, stdev, x).toStringAsFixed(6);
        probabilitiesMap["GT"] = _normDistGT(mean, stdev, x).toStringAsFixed(6);
        return probabilitiesMap;
      }
    } catch (e) {
      print('Error: ${e.toString()}');
      return probabilitiesMap;
    }
  }

  /// Function for computing P(X < x).
  static double _normDistLT(double mean, double stdev, double x) {
    double zscore = (x - mean) / stdev;
    return Normal.cdf(zscore);
  }

  /// Function for computing P(X > x).
  static double _normDistGT(double mean, double stdev, double x) {
    double zscore = (x - mean) / stdev;
    return 1- Normal.cdf(zscore);
  }
}
