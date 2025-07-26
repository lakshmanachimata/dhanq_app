import 'dart:async';
import '../models/debt_doctor_model.dart';
import 'package:flutter/material.dart';

class DebtDoctorService {
  // Simulate API delay
  Future<void> _simulateDelay() async {
    await Future.delayed(const Duration(milliseconds: 800));
  }

  Future<DebtOverviewModel> getDebtOverview() async {
    await _simulateDelay();
    return DebtOverviewModel(
      totalDebt: 185000,
      interestPaid: 42700,
      potentialSavings: 12500,
    );
  }

  Future<DebtBreakdownModel> getDebtBreakdown() async {
    await _simulateDelay();
    return DebtBreakdownModel(
      totalAmount: 185000,
      items: [
        DebtBreakdownItem(
          type: 'Credit Cards',
          amount: 18500,
          color: Colors.red,
          percentage: 10.0,
        ),
        DebtBreakdownItem(
          type: 'Student Loans',
          amount: 55000,
          color: Colors.blue,
          percentage: 29.7,
        ),
        DebtBreakdownItem(
          type: 'Mortgage',
          amount: 110000,
          color: Colors.orange,
          percentage: 59.5,
        ),
        DebtBreakdownItem(
          type: 'Personal Loans',
          amount: 1500,
          color: const Color(0xFF1E3A8A),
          percentage: 0.8,
        ),
      ],
    );
  }

  Future<RepaymentStrategiesModel> getRepaymentStrategies() async {
    await _simulateDelay();
    return RepaymentStrategiesModel(
      avalanche: RepaymentStrategyModel(
        name: 'Avalanche Method',
        description: 'Pay highest interest first',
        interest: 28600,
        payoffTime: 64,
        color: Colors.orange,
        payoffData: [185000, 170000, 155000, 140000, 125000, 110000, 95000, 80000, 65000, 50000, 35000, 20000, 5000, 0],
      ),
      snowball: RepaymentStrategyModel(
        name: 'Snowball Method',
        description: 'Pay smallest debts first',
        interest: 32400,
        payoffTime: 68,
        color: const Color(0xFF1E3A8A),
        payoffData: [185000, 172000, 159000, 146000, 133000, 120000, 107000, 94000, 81000, 68000, 55000, 42000, 29000, 16000, 3000, 0],
      ),
      recommendation: 'The Avalanche method saves you \$3,800 in interest and pays off debt 4 months faster.',
      savings: 3800,
      timeSaved: 4,
    );
  }

  Future<CreditScoreModel> getCreditScore() async {
    await _simulateDelay();
    return CreditScoreModel(
      score: 682,
      maxScore: 850,
      potentialIncrease: 17,
      range: 'Good',
      rangeColor: Colors.green,
      trendData: [665, 670, 675, 680, 682],
      trendLabels: ['Feb', 'Mar', 'Apr', 'May', 'Jun'],
    );
  }

  Future<CreditScoreFactorsModel> getCreditScoreFactors() async {
    await _simulateDelay();
    return CreditScoreFactorsModel(
      factors: [
        CreditScoreFactor(
          name: 'Payment History',
          status: 'Good',
          impact: 'High',
          contribution: 35,
          statusColor: Colors.green,
        ),
        CreditScoreFactor(
          name: 'Credit Utilization',
          status: 'Fair',
          impact: 'High',
          contribution: 30,
          statusColor: Colors.orange,
        ),
        CreditScoreFactor(
          name: 'Length of History',
          status: 'Good',
          impact: 'Medium',
          contribution: 15,
          statusColor: Colors.green,
        ),
        CreditScoreFactor(
          name: 'Credit Mix',
          status: 'Very Good',
          impact: 'Low',
          contribution: 10,
          statusColor: Colors.green,
        ),
        CreditScoreFactor(
          name: 'New Credit',
          status: 'Excellent',
          impact: 'Low',
          contribution: 10,
          statusColor: Colors.green,
        ),
      ],
    );
  }

  Future<void> applyAvalancheStrategy() async {
    await _simulateDelay();
    // Simulate applying the strategy
    print('Avalanche strategy applied successfully!');
  }
} 