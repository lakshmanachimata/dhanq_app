import 'dart:async';
import '../models/financial_health_score_model.dart';
import 'package:flutter/material.dart';

class FinancialHealthScoreService {
  // Simulate API delay
  Future<void> _simulateDelay() async {
    await Future.delayed(const Duration(milliseconds: 800));
  }

  Future<FinancialHealthScoreModel> getFinancialHealthScore() async {
    await _simulateDelay();
    return FinancialHealthScoreModel(
      score: 87,
      maxScore: 100,
      status: 'Good',
      statusColor: Colors.green,
      description: "Your financial health is on the right track, with some opportunities for improvement.",
    );
  }

  Future<List<KeyMetricModel>> getKeyMetrics() async {
    await _simulateDelay();
    return [
      KeyMetricModel(
        label: 'Savings Rate',
        value: '18%',
        trend: '+3.5%',
        isPositiveTrend: true,
        icon: Icons.savings,
      ),
      KeyMetricModel(
        label: 'Debt-to-Income',
        value: '22%',
        trend: '-2.1%',
        isPositiveTrend: true, // Lower is better for debt-to-income
        icon: Icons.description,
      ),
      KeyMetricModel(
        label: 'Investment Growth',
        value: '+12.3%',
        trend: '+1.8%',
        isPositiveTrend: true,
        icon: Icons.trending_up,
      ),
      KeyMetricModel(
        label: 'Emergency Fund',
        value: '5 months',
        status: 'Neutral',
        isPositiveTrend: false,
        icon: Icons.savings,
      ),
    ];
  }

  Future<List<ScoreBreakdownModel>> getScoreBreakdown() async {
    await _simulateDelay();
    return [
      ScoreBreakdownModel(
        category: 'Savings & Investments',
        percentage: 92,
        color: Colors.blue,
      ),
      ScoreBreakdownModel(
        category: 'Debt Management',
        percentage: 83,
        color: Colors.orange,
      ),
      ScoreBreakdownModel(
        category: 'Spending Habits',
        percentage: 72,
        color: Colors.red,
      ),
      ScoreBreakdownModel(
        category: 'Future Planning',
        percentage: 88,
        color: Colors.blue,
      ),
    ];
  }

  Future<List<FinancialInsightModel>> getFinancialInsights() async {
    await _simulateDelay();
    return [
      FinancialInsightModel(
        text: 'Increase emergency fund to 6 months of expenses',
        icon: Icons.savings,
        iconColor: const Color(0xFF1E3A8A),
      ),
      FinancialInsightModel(
        text: 'Consider diversifying investment portfolio',
        icon: Icons.trending_up,
        iconColor: const Color(0xFF1E3A8A),
      ),
      FinancialInsightModel(
        text: 'Maintain current debt repayment strategy',
        icon: Icons.description,
        iconColor: const Color(0xFF1E3A8A),
      ),
    ];
  }

  Future<MonthlyTrendModel> getMonthlyTrend() async {
    await _simulateDelay();
    return MonthlyTrendModel(
      data: [82, 84, 85, 86, 87],
      labels: ['Feb', 'Mar', 'Apr', 'May', 'Jun'],
    );
  }

  Future<void> applyFinancialOptimization() async {
    await _simulateDelay();
    // Simulate applying financial optimization
    print('Financial optimization applied successfully!');
  }

  Future<void> getDetailedInsight(String insightType) async {
    await _simulateDelay();
    // Simulate getting detailed insight
    print('Getting detailed insight for $insightType');
  }
} 