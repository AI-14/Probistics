/**
 * Computes poisson distribution and almost all of its related cases (probabilities and statistics).
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


class PoissonDistribution {

  /// Function for computing all the possible cases (probabilities and statistics) of the distribution.
  static Map<String, String> getAllCasesOfPoissDist(double lambdaT, int x) {
    Map<String, String> probabilitiesMap = Map<String, String>();
    try {
      if (x < 0 || x > 150 || lambdaT < 0 || lambdaT > 10000)
        throw Exception(
            "x should be in range [0, 150]. lambdaT should be in range [0, 10000].");
      else {
        probabilitiesMap["E"] =
            _poissDistE(lambdaT, x).toStringAsFixed(6);

        probabilitiesMap["LT"] =
            _poissDistLT(lambdaT, x).toStringAsFixed(6);

        probabilitiesMap["LTE"] =
            _poissDistLTE(lambdaT, x).toStringAsFixed(6);

        probabilitiesMap["GT"] =
            _poissDistGT(lambdaT, x).toStringAsFixed(6);

        probabilitiesMap["GTE"] =
            _poissDistGTE(lambdaT, x).toStringAsFixed(6);

        probabilitiesMap["Mean"] = lambdaT.toStringAsFixed(6);
        probabilitiesMap["Variance"] = lambdaT.toStringAsFixed(6);
        probabilitiesMap["Standard Deviation"] =
            sqrt(lambdaT).toStringAsFixed(6);

        return probabilitiesMap;
      }
    } catch (e) {
      print('Error: ${e.toString()}');
      return probabilitiesMap;
    }
  }

  /// Function for computing P(X = x).
  static double _poissDistE(double lambdaT, int x) {
    return _poissFormula(lambdaT, x);
  }
  /// Function for computing P(X < x).
  static double _poissDistLT(double lambdaT, int x) {
    return _poissDistLTE(lambdaT, x - 1);
  }

  /// Function for computing P(X <= x).
  static double _poissDistLTE(double lambdaT, int x) {
    double result = 0.0;
    for (int i = 0; i <= x; i++)
      result += _poissFormula(lambdaT, i);
    return result;
  }

  /// Function for computing P(X > x).
  static double _poissDistGT(double lambdaT, int x) {
    return _poissDistGTE(lambdaT, x + 1);
  }

  /// Function for computing P(X >= x).
  static double _poissDistGTE(double lambdaT, int x) {
    double result = 0.0;
    result = _poissDistLT(lambdaT, x);
    return 1 - result;
  }

  /// Utility function that uses PD formula.
  static double _poissFormula(double lambdaT, int x) {
    return (pow(lambdaT, x) * exp(-1 * lambdaT)) / _factUsingLog(x);
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
