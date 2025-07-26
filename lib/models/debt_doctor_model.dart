import 'package:flutter/material.dart';

class DebtOverviewModel {
  final double totalDebt;
  final double interestPaid;
  final double potentialSavings;

  DebtOverviewModel({
    required this.totalDebt,
    required this.interestPaid,
    required this.potentialSavings,
  });

  String get formattedTotalDebt => '\$${totalDebt.toStringAsFixed(0)}';
  String get formattedInterestPaid => '\$${interestPaid.toStringAsFixed(0)}';
  String get formattedPotentialSavings => '\$${potentialSavings.toStringAsFixed(0)}';
}

class DebtBreakdownItem {
  final String type;
  final double amount;
  final Color color;
  final double percentage;

  DebtBreakdownItem({
    required this.type,
    required this.amount,
    required this.color,
    required this.percentage,
  });

  String get formattedAmount => '\$${amount.toStringAsFixed(0)}';
  String get formattedPercentage => '${percentage.toStringAsFixed(1)}%';
}

class DebtBreakdownModel {
  final List<DebtBreakdownItem> items;
  final double totalAmount;

  DebtBreakdownModel({
    required this.items,
    required this.totalAmount,
  });

  String get formattedTotalAmount => '\$${totalAmount.toStringAsFixed(0)}';
}

class RepaymentStrategyModel {
  final String name;
  final String description;
  final double interest;
  final int payoffTime;
  final Color color;
  final List<double> payoffData;

  RepaymentStrategyModel({
    required this.name,
    required this.description,
    required this.interest,
    required this.payoffTime,
    required this.color,
    required this.payoffData,
  });

  String get formattedInterest => '\$${interest.toStringAsFixed(0)}';
  String get formattedPayoffTime => '${payoffTime} months';
}

class RepaymentStrategiesModel {
  final RepaymentStrategyModel avalanche;
  final RepaymentStrategyModel snowball;
  final String recommendation;
  final double savings;
  final int timeSaved;

  RepaymentStrategiesModel({
    required this.avalanche,
    required this.snowball,
    required this.recommendation,
    required this.savings,
    required this.timeSaved,
  });

  String get formattedSavings => '\$${savings.toStringAsFixed(0)}';
  String get formattedTimeSaved => '$timeSaved months';
}

class CreditScoreModel {
  final int score;
  final int maxScore;
  final int potentialIncrease;
  final String range;
  final Color rangeColor;
  final List<double> trendData;
  final List<String> trendLabels;

  CreditScoreModel({
    required this.score,
    required this.maxScore,
    required this.potentialIncrease,
    required this.range,
    required this.rangeColor,
    required this.trendData,
    required this.trendLabels,
  });

  String get formattedScore => '$score out of $maxScore';
  String get formattedPotentialIncrease => '+$potentialIncrease pts';
  double get scorePercentage => (score / maxScore) * 100;
}

class CreditScoreFactor {
  final String name;
  final String status;
  final String impact;
  final double contribution;
  final Color statusColor;

  CreditScoreFactor({
    required this.name,
    required this.status,
    required this.impact,
    required this.contribution,
    required this.statusColor,
  });

  String get formattedContribution => '${contribution.toStringAsFixed(0)}%';
}

class CreditScoreFactorsModel {
  final List<CreditScoreFactor> factors;

  CreditScoreFactorsModel({
    required this.factors,
  });
} 