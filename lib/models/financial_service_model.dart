import 'package:flutter/material.dart';

class FinancialServiceModel {
  final String id;
  final String name;
  final String description;
  final IconData icon;
  final Color color;

  FinancialServiceModel({
    required this.id,
    required this.name,
    required this.description,
    required this.icon,
    required this.color,
  });
} 