import 'package:flutter/material.dart';

enum ActivityType { investment, withdrawal, transfer, dividend, expense }

class ActivityModel {
  final String id;
  final String title;
  final String description;
  final double amount;
  final DateTime timestamp;
  final ActivityType type;

  ActivityModel({
    required this.id,
    required this.title,
    required this.description,
    required this.amount,
    required this.timestamp,
    required this.type,
  });

  String get formattedAmount => '${amount >= 0 ? '+' : ''}₹${_formatNumber(amount)}';
  String get formattedTime => _formatTime(timestamp);
  Color get amountColor => amount >= 0 ? Colors.green : Colors.red;
  IconData get icon => _getIconForType(type);
  Color get iconColor => _getColorForType(type);
}

IconData _getIconForType(ActivityType type) {
  switch (type) {
    case ActivityType.investment:
      return Icons.trending_up;
    case ActivityType.withdrawal:
      return Icons.trending_down;
    case ActivityType.transfer:
      return Icons.swap_horiz;
    case ActivityType.dividend:
      return Icons.account_balance;
    case ActivityType.expense:
      return Icons.shopping_cart;
  }
}

Color _getColorForType(ActivityType type) {
  switch (type) {
    case ActivityType.investment:
      return Colors.green;
    case ActivityType.withdrawal:
      return Colors.red;
    case ActivityType.transfer:
      return Colors.blue;
    case ActivityType.dividend:
      return Colors.orange;
    case ActivityType.expense:
      return Colors.purple;
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

String _formatTime(DateTime timestamp) {
  final now = DateTime.now();
  final difference = now.difference(timestamp);

  if (difference.inDays > 0) {
    return '${difference.inDays}d ago';
  } else if (difference.inHours > 0) {
    return '${difference.inHours}h ago';
  } else if (difference.inMinutes > 0) {
    return '${difference.inMinutes}m ago';
  } else {
    return 'Just now';
  }
} 