/**
 * Computes weibull distribution and almost all of its related cases (probabilities and statistics).
 * 
 * Abbreviations:
 * 1. LT = Less than
 * 2. GT = Greater than
 */

import 'dart:math';
// ignore: import_of_legacy_library_into_null_safe
import 'package:grizzly_distuv/math.dart';

class WeibullDistribution {
  /// Function for computing all the possible cases (probabilities and statistics) of the distribution.
  static Map<String, String> getAllCasesOfWeibullDist(
      double alpha, double beta, double x) {
    Map<String, String> probabilitiesMap = Map<String, String>();
    try {
      if (x <= 0 || alpha <= 0 || beta <= 0)
        throw Exception("x, alpha, beta should be >0.");
      else {
        probabilitiesMap["LT"] =
            _weibullDistLT(alpha, beta, x).toStringAsFixed(6);
        probabilitiesMap["GT"] =
            _weibullDistGT(alpha, beta, x).toStringAsFixed(6);
        probabilitiesMap["Mean"] =
            _weibullDistMean(alpha, beta).toStringAsFixed(6);
        probabilitiesMap["Variance"] =
            _weibullDistVariance(alpha, beta).toStringAsFixed(6);
        probabilitiesMap["Standard Deviation"] =
            _weibullDistStandardDeviation(alpha, beta).toStringAsFixed(6);
        return probabilitiesMap;
      }
    } catch (e) {
      print('Error: ${e.toString()}');
      return probabilitiesMap;
    }
  }

  /// Function for computing P(X < x).
  static double _weibullDistLT(double alpha, double beta, double x) {
    num fracPow = pow(x / alpha, beta);
    return 1 - exp(-1 * fracPow);
  }

  /// Function for computing P(X > x).
  static double _weibullDistGT(double alpha, double beta, double x) {
    return 1 - _weibullDistLT(alpha, beta, x);
  }

  /// Function for computing Mean. 
  static double _weibullDistMean(double alpha, double beta) {
    double constant = 1 + (1 / beta);
    return alpha * gamma(double.parse(constant.toStringAsFixed(1)));
  }

  /// Function for computing variance.
  static double _weibullDistVariance(double alpha, double beta) {
    double constant1 = double.parse((1 + (2 / beta)).toStringAsFixed(1));
    double constant2 = double.parse((1 + (1 / beta)).toStringAsFixed(1));
    double firstTerm = pow(alpha, 2) * gamma(constant1);
    num secondTerm = pow(alpha * gamma(constant2), 2);
    return firstTerm - secondTerm;
  }

  /// Function for computing standard deviation. 
  static double _weibullDistStandardDeviation(double alpha, double beta) {
    return sqrt(_weibullDistVariance(alpha, beta));
  }
}
