import 'dart:async';
import '../models/tax_whisperer_model.dart';
import 'package:flutter/material.dart';

class TaxWhispererService {
  // Simulate API delay
  Future<void> _simulateDelay() async {
    await Future.delayed(const Duration(milliseconds: 800));
  }

  Future<TaxHealthScoreModel> getTaxHealthScore() async {
    await _simulateDelay();
    return TaxHealthScoreModel(
      score: 82,
      maxScore: 100,
      status: 'Good',
      statusColor: Colors.blue,
      description: "You're on track, but there are a few opportunities to optimize your tax situation.",
      quickImprovements: [
        QuickImprovementModel(
          title: 'Maximize your retirement contributions',
          isCompleted: false,
        ),
        QuickImprovementModel(
          title: 'Review home office deduction eligibility',
          isCompleted: false,
        ),
      ],
    );
  }

  Future<TaxLiabilityForecastModel> getTaxLiabilityForecast() async {
    await _simulateDelay();
    return TaxLiabilityForecastModel(
      quarterlyTaxes: [
        QuarterlyTaxModel(
          quarter: 'Q1',
          dueDate: DateTime(2024, 4, 15),
          amount: 3150,
          percentageChange: null,
          isDecrease: false,
        ),
        QuarterlyTaxModel(
          quarter: 'Q2',
          dueDate: DateTime(2024, 6, 15),
          amount: 2980,
          percentageChange: 5,
          isDecrease: true,
        ),
        QuarterlyTaxModel(
          quarter: 'Q3',
          dueDate: DateTime(2024, 9, 15),
          amount: 2850,
          percentageChange: 4,
          isDecrease: true,
        ),
        QuarterlyTaxModel(
          quarter: 'Q4',
          dueDate: DateTime(2025, 1, 15),
          amount: 2650,
          percentageChange: 7,
          isDecrease: true,
        ),
      ],
      chartData: [3150, 2980, 2850, 2650],
    );
  }

  Future<List<PersonalizedDeductionModel>> getPersonalizedDeductions() async {
    await _simulateDelay();
    return [
      PersonalizedDeductionModel(
        title: 'Home Office',
        description: 'Based on your work-from-home activity',
        estimatedValue: 1850,
        status: 'Eligible',
        statusColor: Colors.green,
        actionText: 'Learn More',
        actionColor: Colors.red,
        icon: Icons.home,
      ),
      PersonalizedDeductionModel(
        title: 'Healthcare Expenses',
        description: 'From your medical receipts and HSA',
        estimatedValue: 1250,
        status: 'Eligible',
        statusColor: Colors.green,
        actionText: 'Learn More',
        actionColor: Colors.red,
        icon: Icons.health_and_safety,
      ),
      PersonalizedDeductionModel(
        title: 'Retirement Contributions',
        description: '401(k) and IRA contributions',
        estimatedValue: 2300,
        status: 'Eligible',
        statusColor: Colors.green,
        actionText: 'Learn More',
        actionColor: Colors.red,
        icon: Icons.account_balance,
      ),
      PersonalizedDeductionModel(
        title: 'Child Tax Credit',
        description: 'Not eligible based on dependents',
        estimatedValue: 0,
        status: 'Not Eligible',
        statusColor: Colors.grey,
        actionText: 'Check Eligibility',
        actionColor: Colors.grey,
        icon: Icons.face,
      ),
    ];
  }

  Future<void> applyTaxOptimization() async {
    await _simulateDelay();
    // Simulate applying tax optimization
    print('Tax optimization applied successfully!');
  }

  Future<void> learnMoreAboutDeduction(String deductionType) async {
    await _simulateDelay();
    // Simulate learning more about deduction
    print('Learning more about $deductionType deduction');
  }
} 