/**
 * Computes exponential distribution and almost all of its related cases (probabilities and statistics).
 * 
 * Abbreviations:
 * 1. LT = Less than
 * 2. GT = Greater than
 */

import 'dart:core';
import 'dart:math';

class ExponentialDistribution {

  /// Function for computing all the possible cases (probabilities and statistics) of the distribution.
  static Map<String, String> getAllCasesOfExponentialDist(
      double lambda, double x) {
    Map<String, String> probabilitiesMap = Map<String, String>();
    try {
      if (x <= 0)
        throw Exception("x should be > 0.");
      else {
        probabilitiesMap["LT"] = _expDistLT(lambda, x).toStringAsFixed(6);
        probabilitiesMap["GT"] = _expDistGT(lambda, x).toStringAsFixed(6);
        probabilitiesMap["Mean"] = (1 / lambda).toStringAsFixed(6);
        probabilitiesMap["Variance"] = pow(1 / lambda, 2).toStringAsFixed(6);
        probabilitiesMap["Standard Deviation"] =
            (1 / lambda).toStringAsFixed(6);
        return probabilitiesMap;
      }
    } catch (e) {
      print('Error: ${e.toString()}');
      return probabilitiesMap;
    }
  }

  /// Function for computing P(X < x).
  static double _expDistLT(double lambda, double x) {
    return 1 - exp(-1 * lambda * x);
  }

  /// Function for computing P(X > x).
  static double _expDistGT(double lambda, double x) {
    return 1 - _expDistLT(lambda, x);
  }
}
