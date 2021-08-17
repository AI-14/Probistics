/**
 * Computes negative binomial r success distribution and almost all of its related cases (probabilities and statistics).
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

class NegativeBinomialDistributionRSuccess {

  /// Function for computing all the possible cases (probabilities and statistics) of the distribution.
  static Map<String, String> getAllCasesOfNegativeBinomialDistRSuccess(double p, int x, int r) {
    Map<String, String> probabilitiesMap = Map<String, String>();
    try {
      if (x < 1 || x > 150 || p < 0.0 || p > 1.0 || r < 1 || r > x)
        throw Exception(
            "x should be in range [1, 150]. p should be in range [0.0, 1.0]. r should be in range [1, x].");
      else {
        probabilitiesMap["E"] =
            _negBinomDistE(p, x, r).toStringAsFixed(6);
        probabilitiesMap["LT"] =
            _negBinomDistLT(p, x, r).toStringAsFixed(6);

        probabilitiesMap["LTE"] =
            _negBinomDistLTE(p, x, r).toStringAsFixed(6);

        probabilitiesMap["GT"] =
            _negBinomDistGT(p, x, r).toStringAsFixed(6);

        probabilitiesMap["GTE"] =
            _negBinomDistGTE(p, x, r).toStringAsFixed(6);

        probabilitiesMap["Mean"] =
            _negBinomDistMean(p, r).toStringAsFixed(6);
        probabilitiesMap["Variance"] =
            _negBinomDistVariance(p, r).toStringAsFixed(6);

        probabilitiesMap["Standard Deviation"] =
            _negBinomDistStandardDeviation(p, r).toStringAsFixed(6);

        return probabilitiesMap;
      }
    } catch (e) {
      print('Error: ${e.toString()}');
      return probabilitiesMap;
    }
  }

  /// Function for computing P(X = x).
  static double _negBinomDistE(p, x, r) {
    return _negBinomFormula(p, x, r);
  }

  /// Function for computing P(X < x).
  static double _negBinomDistLT(p, x, r) {
    return _negBinomDistLTE(p, x - 1, r);
  }

  /// Function for computing P(X <= x).
  static double _negBinomDistLTE(p, x, r) {
    double result = 0.0;
    for (int i = r; i <= x; i++) result += _negBinomFormula(p, i, r);
    return result;
  }

  /// Function for computing P(X > x).
  static double _negBinomDistGT(p, x, r) {
    return _negBinomDistGTE(p, x + 1, r);
  }

  /// Function for computing P(X >= x).
  static double _negBinomDistGTE(p, x, r) {
    double result = 0.0;
    result = _negBinomDistLT(p, x, r);
    return 1 - result;
  }

  /// Function for computing Mean. 
  static double _negBinomDistMean(double p, int r) {
    return r / p;
  }

  /// Function for computing variance. 
  static double _negBinomDistVariance(double p, int r) {
    return (r * (1 - p)) / pow(p, 2);
  }

  /// Function for computing standard deviation.
  static double _negBinomDistStandardDeviation(double p, int r) {
    return sqrt(_negBinomDistVariance(p, r));
  }

  /// Utility function that uses NBRSD formula.
  static double _negBinomFormula(p, x, r) {
    double x_1Cr_1 =
        (_factUsingLog(x - 1) / (_factUsingLog(x - r) * _factUsingLog(r - 1)))
            .roundToDouble();
    return (x_1Cr_1 * pow(p, r) * pow(1 - p, x - r));
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