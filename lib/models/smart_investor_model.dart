import 'package:flutter/material.dart';

class PortfolioAllocationModel {
  final double equity;
  final double debt;
  final double gold;
  final double cash;

  PortfolioAllocationModel({
    required this.equity,
    required this.debt,
    required this.gold,
    required this.cash,
  });

  List<AllocationItem> get allocationItems => [
    AllocationItem(name: 'Equity', percentage: equity, color: const Color(0xFF8B4513)),
    AllocationItem(name: 'Debt', percentage: debt, color: const Color(0xFFFFD700)),
    AllocationItem(name: 'Gold', percentage: gold, color: const Color(0xFFFFB6C1)),
    AllocationItem(name: 'Cash', percentage: cash, color: const Color(0xFFDEB887)),
  ];
}

class AllocationItem {
  final String name;
  final double percentage;
  final Color color;

  AllocationItem({
    required this.name,
    required this.percentage,
    required this.color,
  });

  String get formattedPercentage => '${percentage.toStringAsFixed(0)}%';
}

class ActionableInsightModel {
  final String id;
  final String title;
  final String description;
  final String actionText;
  final Color accentColor;

  ActionableInsightModel({
    required this.id,
    required this.title,
    required this.description,
    required this.actionText,
    this.accentColor = const Color(0xFF8B4513),
  });
}

class MarketSentimentModel {
  final String id;
  final String title;
  final String description;
  final String actionText;
  final String? timeframe;
  final List<double>? chartData;
  final Color accentColor;

  MarketSentimentModel({
    required this.id,
    required this.title,
    required this.description,
    required this.actionText,
    this.timeframe,
    this.chartData,
    this.accentColor = const Color(0xFF8B4513),
  });
}

class InterestRateImpactModel {
  final String title;
  final String timeframe;
  final List<double> chartData;
  final String description;
  final String actionText;

  InterestRateImpactModel({
    required this.title,
    required this.timeframe,
    required this.chartData,
    required this.description,
    required this.actionText,
  });
} 