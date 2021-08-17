/**
 * Computes hypergeometric distribution and almost all of its related cases (probabilities and statistics).
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


class HypergeometricDistribution {

  /// Function for computing all the possible cases (probabilities and statistics) of the distribution.
  static Map<String, String> getAllCasesOfHypergeometricDist(
      int K, int N, int n, int x) {
    Map<String, String> probabilitiesMap = Map<String, String>();
    try {
      int lowerLimitX = max(0, n + K - N);
      int upperLimitX = min(n, K);
      if (N < 0 || N > 150 || K < 0 || K > N || n < 0 || n > N || x < lowerLimitX || x > upperLimitX)
        throw Exception(
            "N should be in range [0, 150]. K and n should be in range [0, N]. x should be in range [max(0, n + K - N), min(n, K)]");
      else {
        probabilitiesMap["E"] =
            _hypergeomDistE(K,N, n, x).toStringAsFixed(6);

        probabilitiesMap["LT"] =
            _hypergeomDistLT(K,N, n, x).toStringAsFixed(6);

        probabilitiesMap["LTE"] =
            _hypergeomDistLTE(K,N, n, x).toStringAsFixed(6);

        probabilitiesMap["GT"] =
            _hypergeomDistGT(K,N, n, x).toStringAsFixed(6);

        probabilitiesMap["GTE"] =
            _hypergeomDistGTE(K,N, n, x).toStringAsFixed(6);

        probabilitiesMap["Mean"] =
            _hypergeomDistMean(K,N, n).toStringAsFixed(6);
        probabilitiesMap["Variance"] =
            _hypergeomDistVariance(K,N, n).toStringAsFixed(6);
        probabilitiesMap["Standard Deviation"] =
            _hypergeomDistStandardDeviation(K,N, n)
                .toStringAsFixed(6);
        return probabilitiesMap;
      }
    } catch (e) {
      print('Error: ${e.toString()}');
      return probabilitiesMap;
    }
  }

  /// Function for computing P(X = x).
  static double _hypergeomDistE(int K, int N, int n, int x) {
    return _hypergeomFormula(K,N, n, x);
  }

  /// Function for computing P(X < x).
  static double _hypergeomDistLT(int K, int N, int n, int x) {
    return _hypergeomDistLTE(K,N, n, x - 1);
  }

  /// Function for computing P(X <= x).
  static double _hypergeomDistLTE(int K, int N, int n, int x) {
    int initial = max(0, n + K - N);
    double result = 0.0;
    for (int i = initial; i <= x; i++) {
      result += _hypergeomFormula(K,N, n, i);
    }
    return result;
  }

  /// Function for computing P(X > x).
  static double _hypergeomDistGT(int K, int N, int n, int x) {
    return _hypergeomDistGTE(K,N, n, x + 1);
  }

  /// Function for computing P(X >= x).
  static double _hypergeomDistGTE(int K, int N, int n, int x) {
    double result = 0.0;
    result = _hypergeomDistLT(K,N, n, x);
    return 1 - result;
  }

  /// Function for computing Mean. 
  static double _hypergeomDistMean(int K, int N, int n) {
    return (n * K) / N;
  }

  /// Function for computing variance. 
  static double _hypergeomDistVariance(int K, int N, int n) {
    return ((n * K) / N) * (1 - (K / N)) * ((N - n) / (N - 1));
  }

  /// Function for computing standard deviation.
  static double _hypergeomDistStandardDeviation(int K, int N, int n) {
    return sqrt(_hypergeomDistVariance(K,N, n));
  }

  /// Utility function that uses HGD formula.
  static double _hypergeomFormula(int K, int N, int n, int x) {
    double KCx = (_factUsingLog(K) / (_factUsingLog(K - x) * _factUsingLog(x)))
        .roundToDouble();

    double N_KCn_x = (_factUsingLog(N - K) /
            (_factUsingLog(N - K - n + x) * _factUsingLog(n - x)))
        .roundToDouble();

    double NCn = (_factUsingLog(N) / (_factUsingLog(N - n) * _factUsingLog(n)))
        .roundToDouble();
    return (KCx * N_KCn_x) / NCn;
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