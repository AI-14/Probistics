/**
 * Computes geometric distribution (k trials) and almost all of its related cases (probabilities and statistics).
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


class GeometricDistributionKTrials {

  /// Function for computing all the possible cases (probabilities and statistics) of the distribution.
  static Map<String, String> getAllCasesOfGeometricDistKTrials(double p, int x) {
    Map<String, String> probabilitiesMap = Map<String, String>();
    try {
      if (x < 1 || x > 500 || p < 0.0 || p > 1.0)
        throw Exception(
            "x should be in range [1, 500]. p should be in range [0.0, 1.0].");
      else {
        probabilitiesMap["E"] = _geomDistE(p, x).toStringAsFixed(6);
        probabilitiesMap["LT"] =
            _geomDistLT(p, x).toStringAsFixed(6);
        probabilitiesMap["LTE"] =
            _geomDistLTE(p, x).toStringAsFixed(6);
        probabilitiesMap["GT"] =
            _geomDistGT(p, x).toStringAsFixed(6);
        probabilitiesMap["GTE"] =
            _geomDistGTE(p, x).toStringAsFixed(6);
        probabilitiesMap["Mean"] = _geomDistMean(p).toStringAsFixed(6);
        probabilitiesMap["Variance"] =
            _geomDistVariance(p).toStringAsFixed(6);
        probabilitiesMap["Standard Deviation"] =
            _geomDistStandardDeviation(p).toStringAsFixed(6);

        return probabilitiesMap;
      }
    } catch (e) {
      print('Error: ${e.toString()}');
      return probabilitiesMap;
    }
  }

  /// Function for computing P(X = x).
  static double _geomDistE(p, x) {
    return _geomFormulaKTrials(p, x);
  }

  /// Function for computing P(X < x).
  static double _geomDistLT(p, x) {
    return _geomDistLTE(p, x - 1);
  }

  /// Function for computing P(X <= x).
  static double _geomDistLTE(p, x) {
    double result = 0.0;
    for (int i = 1; i <= x; i++) result += _geomFormulaKTrials(p, i);
    return result;
  }

  /// Function for computing P(X > x).
  static double _geomDistGT(p, x) {
    return _geomDistGTE(p, x + 1);
  }

  /// Function for computing P(X >= x).
  static double _geomDistGTE(p, x) {
    double result = 0.0;
    result = _geomDistLT(p, x);
    return 1 - result;
  }

  /// Function for computing Mean. 
  static double _geomDistMean(double p) {
    return 1 / p;
  }

  /// Function for computing variance. 
  static double _geomDistVariance(double p) {
    return (1 - p) / pow(p, 2);
  }

  /// Function for computing standard deviation.
  static double _geomDistStandardDeviation(double p) {
    return sqrt(_geomDistVariance(p));
  }

  /// Utility function that uses GDKT formula.
  static double _geomFormulaKTrials(p, x) {
    return p * pow(1 - p, x - 1);
  }
}