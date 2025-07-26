import 'package:flutter/material.dart';

class FinancialServiceModel {
  final String id;
  final String name;
  final IconData icon;
  final Color color;
  final String description;

  FinancialServiceModel({
    required this.id,
    required this.name,
    required this.icon,
    required this.color,
    required this.description,
  });

  static List<FinancialServiceModel> get defaultServices => [
    FinancialServiceModel(
      id: 'asset_management',
      name: 'Asset Management',
      icon: Icons.business,
      color: Colors.blue,
      description: 'Comprehensive asset tracking and management',
    ),
    FinancialServiceModel(
      id: 'smart_investor',
      name: 'Smart Investor Agent',
      icon: Icons.account_balance,
      color: Colors.green,
      description: 'AI-powered investment recommendations',
    ),
    FinancialServiceModel(
      id: 'debt_doctor',
      name: 'Debt-Doctor',
      icon: Icons.medical_services,
      color: Colors.red,
      description: 'Debt management and optimization',
    ),
    FinancialServiceModel(
      id: 'tax_whisperer',
      name: 'Tax Whisperer',
      icon: Icons.description,
      color: Colors.orange,
      description: 'Tax planning and optimization',
    ),
    FinancialServiceModel(
      id: 'financial_health',
      name: 'Financial Health Score',
      icon: Icons.favorite,
      color: Colors.pink,
      description: 'Track your financial wellness',
    ),
    FinancialServiceModel(
      id: 'fintech_integration',
      name: 'FinTech Integration',
      icon: Icons.api,
      color: Colors.purple,
      description: 'Integration with other FinTechs/APIs',
    ),
  ];
} 