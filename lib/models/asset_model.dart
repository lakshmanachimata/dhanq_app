import 'package:flutter/material.dart';

class AssetAllocation {
  final String category;
  final double percentage;
  final double value;
  final Color color;

  AssetAllocation({
    required this.category,
    required this.percentage,
    required this.value,
    required this.color,
  });

  String get formattedValue => '₹${_formatNumber(value)}';
  String get formattedPercentage => '${percentage.toStringAsFixed(0)}%';

  String _formatNumber(double number) {
    if (number >= 100000) {
      return '${(number / 100000).toStringAsFixed(1)}L';
    } else if (number >= 1000) {
      return '${(number / 1000).toStringAsFixed(1)}K';
    }
    return number.toStringAsFixed(0);
  }
}

class AssetItem {
  final String name;
  final double value;
  final double changePercentage;
  final String category;

  AssetItem({
    required this.name,
    required this.value,
    required this.changePercentage,
    required this.category,
  });

  String get formattedValue => '₹${_formatNumber(value)}';
  String get formattedChange => '${changePercentage >= 0 ? '+' : ''}${changePercentage.toStringAsFixed(1)}%';
  bool get isPositive => changePercentage >= 0;
  Color get changeColor => isPositive ? Colors.green : Colors.red;

  String _formatNumber(double number) {
    if (number >= 100000) {
      return '${(number / 100000).toStringAsFixed(1)}L';
    } else if (number >= 1000) {
      return '${(number / 1000).toStringAsFixed(1)}K';
    }
    return number.toStringAsFixed(0);
  }
}

class AssetCategory {
  final String name;
  final double totalValue;
  final List<AssetItem> items;

  AssetCategory({
    required this.name,
    required this.totalValue,
    required this.items,
  });

  String get formattedTotalValue => '₹${_formatNumber(totalValue)}';

  String _formatNumber(double number) {
    if (number >= 100000) {
      return '${(number / 100000).toStringAsFixed(1)}L';
    } else if (number >= 1000) {
      return '${(number / 1000).toStringAsFixed(1)}K';
    }
    return number.toStringAsFixed(0);
  }
}

enum AssetTab { assets, liabilities, recurring } 