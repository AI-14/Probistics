/**
 * Computes lognormal distribution and almost all of its related cases (probabilities and statistics).
 * 
 * Abbreviations:
 * 1. LT = Less than
 * 2. GT = Greater than
 */


import 'dart:core';
import 'dart:math';
import 'package:normal/normal.dart';


class LognormalDistribution {
  /// Function for computing all the possible cases (probabilities and statistics) of the distribution.
  static Map<String, String> getAllCasesOfLognormalDist(
      double theta, double omega, double x) {
    Map<String, String> probabilitiesMap = Map<String, String>();
    try {
      if (x <= 0)
        throw Exception("x should be >0.");
      else {
        probabilitiesMap["LT"] =
            _lognormDistLT(theta, omega, x).toStringAsFixed(6);
        probabilitiesMap["GT"] =
            _lognormDistGT(theta, omega, x).toStringAsFixed(6);
        probabilitiesMap["Mean"] =
            _lognormDistMean(theta, omega).toStringAsFixed(6);
        probabilitiesMap["Variance"] =
            _lognormDistVariance(theta, omega).toStringAsFixed(6);
        probabilitiesMap["Standard Deviation"] =
            _lognormDistStandardDeviation(theta, omega).toStringAsFixed(6);
        return probabilitiesMap;
      }
    } catch (e) {
      print('Error: ${e.toString()}');
      return probabilitiesMap;
    }
  }

  /// Function for computing P(X < x).
  static double _lognormDistLT(double theta, double omega, double x) {
    double normalizedVal = (log(x) - theta) / omega;
    return Normal.cdf(normalizedVal);
  }

  /// Function for computing P(X > x).
  static double _lognormDistGT(double theta, double omega, double x) {
    return 1 - _lognormDistLT(theta, omega, x);
  }

  /// Function for computing Mean. 
  static double _lognormDistMean(double theta, double omega) {
    return exp(theta + (pow(omega, 2)) / 2);
  }

  /// Function for computing variance.
  static double _lognormDistVariance(double theta, double omega) {
    double firstTerm = exp(2 * theta + pow(omega, 2));
    double secondTerm = exp(pow(omega, 2)) - 1;
    return firstTerm * secondTerm;
  }

  /// Function for computing standard deviation. 
  static double _lognormDistStandardDeviation(double theta, double omega) {
    return sqrt(_lognormDistVariance(theta, omega));
  }
}
