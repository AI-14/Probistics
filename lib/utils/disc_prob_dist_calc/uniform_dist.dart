/**
 * Computes uniform distribution and almost all of its related cases (probabilities and statistics).
 * 
 * Abbreviations:
 * 1. E = Equals
 * 2. LT = Less than
 * 3. LTE = Less than or equal
 * 4. GT = Greater than
 * 5. GTE = Greater than or equal
 */


import 'dart:math';
import 'dart:core';


class DiscreteUniformDistribution {

  /// Function for computing all the possible cases (probabilities and statistics) of the distribution.
  static Map<String, String> getAllCasesOfUniformDist(int a, int b, int x) {
    Map<String, String> probabilitiesMap = Map<String, String>();
    try {
      if (
          x > b ||
          x < a 
          )
        throw Exception(
            "x should be in range [a, b].");
      else {
        probabilitiesMap["E"] =
            _uniDistE(a, b, x).toStringAsFixed(6);
        probabilitiesMap["LT"] =
            _uniDistLT(a, b, x).toStringAsFixed(6);
        probabilitiesMap["LTE"] =
            _uniDistLTE(a, b, x).toStringAsFixed(6);
        probabilitiesMap["GT"] =
            _uniDistGT(a, b, x).toStringAsFixed(6);
        probabilitiesMap["GTE"] =
            _uniDistGTE(a, b, x).toStringAsFixed(6);
        probabilitiesMap["Mean"] = __uniDistMean(a, b).toStringAsFixed(6);
        probabilitiesMap["Variance"] =
            _uniDistVariance(a, b).toStringAsFixed(6);
        probabilitiesMap["Standard Deviation"] =
            _uniDistStandardDeviation(a, b).toStringAsFixed(6);
        return probabilitiesMap;
      }
    } catch (e) {
      print('Error: ${e.toString()}');
      return probabilitiesMap;
    }
  }

  /// Function for computing P(X = x).
  static double _uniDistE(int a, int b, int x) {
    return 1 / (b - a + 1);
  }

  /// Function for computing P(X < x).
  static double _uniDistLT(int a,  int b,  int x) {
    return _uniDistLTE(a, b, x - 1);
  }

  /// Function for computing P(X <= x).
  static double _uniDistLTE(int a,  int b,  int x) {
    return (x - a + 1) / (b - a + 1);
  }

  /// Function for computing P(X > x).
  static double _uniDistGT(int a,  int b,  int x) {
    return _uniDistGTE(a, b, x+1);
  }

  /// Function for computing P(X >= x).
  static double _uniDistGTE(int a,  int b,  int x) {
    double result = 0.0;
    result = _uniDistLT(a,b, x);
    return 1 - result;
  }

  /// Function for computing Mean. 
  static double __uniDistMean(int a,  int b) {
    return (b + a) / 2;
  }

  /// Function for computing variance. 
  static double _uniDistVariance(int a,  int b) {
    return (pow((b - a + 1), 2) - 1) / 12;
  }

  /// Function for computing standard deviation.
  static double _uniDistStandardDeviation(int a,  int b) {
    return sqrt(_uniDistVariance(a, b));
  }
}