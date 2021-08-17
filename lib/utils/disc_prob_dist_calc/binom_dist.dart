/**
 * Computes binomial distribution and almost all of its related cases (probabilities and statistics).
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


class BinomialDistribution {

  /// Function for computing all the possible cases (probabilities and statistics) of the distribution.
  static Map<String, String> getAllCasesOfBinomDist(int n,  double p,  int x) {
    Map<String, String> probabilitiesMap = Map<String, String>();
    try {
      if (x < 0 || x > n || n > 150 || n < 1 || p < 0.0 || p > 1.0)
        throw Exception(
            "x should be in range [0, $n]. n should be in range [1, 150]. p should be in range [0.0, 1.0].");
      else {
        probabilitiesMap["E"] =
            _binomDistE(n, p, x).toStringAsFixed(6);
        probabilitiesMap["LT"] =
            _binomDistLT(n, p, x).toStringAsFixed(6);
        probabilitiesMap["LTE"] =
            _binomDistLTE(n, p, x).toStringAsFixed(6);
        probabilitiesMap["GT"] =
            _binomDistGT(n, p, x).toStringAsFixed(6);
        probabilitiesMap["GTE"] =
            _binomDistGTE(n, p, x).toStringAsFixed(6);
        probabilitiesMap["Mean"] = _binomMean(n, p).toStringAsFixed(6);
        probabilitiesMap["Variance"] =
            _binomVariance(n, p).toStringAsFixed(6);
        probabilitiesMap["Standard Deviation"] =
            _binomStandardDeviation(n, p).toStringAsFixed(6);
        return probabilitiesMap;
      }
    } catch (e) {
      print('Error: ${e.toString()}');
      return probabilitiesMap;
    }
  }

  /// Function for computing P(X = x).
  static double _binomDistE(int n,  double p,  int x) {
    return _binomialFormula(n, p, x);
  }

  /// Function for computing P(X < x).
  static double _binomDistLT(int n,  double p,  int x) {
    return _binomDistLTE(n, p, x - 1);
  }

  /// Function for computing P(X <= x).
  static double _binomDistLTE(int n,  double p,  int x) {
    double result = 0.0;
    for (int i = 0; i <= x; i++) {
      result += _binomialFormula(n, p, i);
    }
    return result;
  }

  /// Function for computing P(X > x).
  static double _binomDistGT(int n,  double p,  int x) {
    return _binomDistGTE(n, p, x + 1);
  }

  /// Function for computing P(X >= x).
  static double _binomDistGTE(int n,  double p,  int x) {
    double result = 0.0;
    for (int i = x; i <= n; i++) {
      result += _binomialFormula(n, p, i);
    }
    return result;
  }

  /// Function for computing Mean. 
  static double _binomMean(int n,  double p) {
    return n * p;
  }

  /// Function for computing variance. 
  static double _binomVariance(int n,  double p) {
    return n * p * (1 - p);
  }

  /// Function for computing standard deviation. 
  static double _binomStandardDeviation(int n,  double p) {
    return sqrt(_binomVariance(n, p));
  }

  /// Utility function that uses BD formula.
  static double _binomialFormula(int n,  double p,  int x) {
    double nCx = (_factUsingLog(n) / (_factUsingLog(x) * _factUsingLog(n - x)))
        .roundToDouble();
    return (nCx * pow(p, x) * pow(1 - p, n - x));
  }

  /// Utility function for computing factorial of a given number.
  static double _factUsingLog(int n) {
    double fact = 0;
    if (n == 0)
      return 1;
    else {
      for (int i = 1; i <= n; i++) fact += log(i);
    }
    return exp(fact).roundToDouble();
  }
}