import 'package:flutter/material.dart';

enum ActivityType { investment, expense, income }

class ActivityModel {
  final String id;
  final String title;
  final double amount;
  final ActivityType type;
  final DateTime date;
  final String icon;

  ActivityModel({
    required this.id,
    required this.title,
    required this.amount,
    required this.type,
    required this.date,
    required this.icon,
  });

  factory ActivityModel.fromJson(Map<String, dynamic> json) {
    return ActivityModel(
      id: json['id'],
      title: json['title'],
      amount: (json['amount'] as num).toDouble(),
      type: ActivityType.values.firstWhere(
        (e) => e.toString() == 'ActivityType.${json['type']}',
      ),
      date: DateTime.parse(json['date']),
      icon: json['icon'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'amount': amount,
      'type': type.toString().split('.').last,
      'date': date.toIso8601String(),
      'icon': icon,
    };
  }

  String get formattedAmount {
    final prefix = type == ActivityType.income ? '+₹' : '₹';
    return '$prefix${_formatNumber(amount)}';
  }

  String get formattedDate {
    final now = DateTime.now();
    final difference = now.difference(date).inDays;

    if (difference == 0) {
      return 'Today';
    } else if (difference == 1) {
      return 'Yesterday';
    } else if (difference < 7) {
      return '${difference} days ago';
    } else {
      return '${date.day} ${_getMonthName(date.month)}';
    }
  }

  String _formatNumber(double number) {
    if (number >= 100000) {
      return '${(number / 100000).toStringAsFixed(1)}L';
    } else if (number >= 1000) {
      return '${(number / 1000).toStringAsFixed(1)}K';
    }
    return number.toStringAsFixed(0);
  }

  String _getMonthName(int month) {
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return months[month - 1];
  }

  Color get amountColor {
    switch (type) {
      case ActivityType.income:
        return Colors.green;
      case ActivityType.expense:
        return Colors.red;
      case ActivityType.investment:
        return Colors.blue;
    }
  }
} 