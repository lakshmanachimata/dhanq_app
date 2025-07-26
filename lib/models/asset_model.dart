import 'package:flutter/material.dart';

class AssetModel {
  final String id;
  final String name;
  final double value;
  final double percentageChange;
  final AssetType type;
  final String category;

  AssetModel({
    required this.id,
    required this.name,
    required this.value,
    required this.percentageChange,
    required this.type,
    required this.category,
  });

  String get formattedValue => '₹${_formatNumber(value)}';
  String get formattedChange => '${percentageChange >= 0 ? '+' : ''}${percentageChange.toStringAsFixed(1)}%';
  Color get changeColor => percentageChange >= 0 ? Colors.green : Colors.red;
  bool get isPositive => percentageChange >= 0;
}

enum AssetType { stocks, mutualFunds, realEstate, fixedIncome, cash, others }

class AssetAllocationModel {
  final double totalNetWorth;
  final double ytdChange;
  final List<AssetAllocationItem> allocations;

  AssetAllocationModel({
    required this.totalNetWorth,
    required this.ytdChange,
    required this.allocations,
  });

  String get formattedNetWorth => '₹${_formatNumber(totalNetWorth)}';
  String get formattedYtdChange => '${ytdChange >= 0 ? '+' : ''}${ytdChange.toStringAsFixed(1)}% YTD';
  Color get ytdColor => ytdChange >= 0 ? Colors.green : Colors.red;
  bool get isYtdPositive => ytdChange >= 0;
}

class AssetAllocationItem {
  final String name;
  final double percentage;
  final double value;
  final Color color;

  AssetAllocationItem({
    required this.name,
    required this.percentage,
    required this.value,
    required this.color,
  });

  String get formattedValue => '₹${_formatNumber(value)}';
  String get formattedPercentage => '${percentage.toStringAsFixed(0)}%';
}

class AssetCategoryModel {
  final String name;
  final double totalValue;
  final List<AssetModel> assets;

  AssetCategoryModel({
    required this.name,
    required this.totalValue,
    required this.assets,
  });

  String get formattedTotalValue => '₹${_formatNumber(totalValue)}';
}

String _formatNumber(double number) {
  if (number >= 100000) {
    return '${(number / 100000).toStringAsFixed(1)}L';
  } else if (number >= 1000) {
    return '${(number / 1000).toStringAsFixed(1)}K';
  }
  return number.toStringAsFixed(0);
} 