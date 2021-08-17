/**
 * Computes uniform continuous distribution and almost all of its related cases (probabilities and statistics).
 * 
 * Abbreviations:
 * 1. LT = Less than
 * 2. GT = Greater than
 */

import 'dart:math';
import 'dart:core';

class UniformContinuousDistribution {

  /// Function for computing all the possible cases (probabilities and statistics) of the distribution.
  static Map<String, String> getAllCasesOfUniformContinuousDist(
      double a, double b, double x) {
    Map<String, String> probabilitiesMap = Map<String, String>();
    try {
      if(x < a || x > b || a > b) throw Exception("x should be in range [a,b] and a < b.");
      else {
        probabilitiesMap["LT"] = _uniDistLT(a, b, x).toStringAsFixed(6);
        probabilitiesMap["GT"] = _uniDistGT(a, b, x).toStringAsFixed(6);
        probabilitiesMap["Mean"] = _uniDistMean(a, b).toStringAsFixed(6);
        probabilitiesMap["Variance"] = _uniDistVariance(a, b).toStringAsFixed(6);
        probabilitiesMap["Standard Deviation"] = _uniDistStandardDeviation(a, b).toStringAsFixed(6);
        return probabilitiesMap;
      }
    }
    catch (e) {
      print('Error: ${e.toString()}');
      return probabilitiesMap;
    }
  }

  /// Function for computing P(X < x).
  static double _uniDistLT(double a, double b, double x) {
    return (x-a) / (b-a);
  }

  /// Function for computing P(X > x).
  static double _uniDistGT(double a, double b, double x) {
    return 1 - _uniDistLT(a, b, x);
  }

  /// Function for computing Mean. 
  static double _uniDistMean(double a, double b) {
    return (a+b)/2;
  } 

  /// Function for computing variance.
  static double _uniDistVariance(double a, double b) {
    return pow((b-a), 2)/12;
  }

  /// Function for computing standard deviation. 
  static double _uniDistStandardDeviation(double a, double b) {
    return sqrt(_uniDistVariance(a, b));
  }
}
