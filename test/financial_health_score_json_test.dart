import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:dhanq_app/models/financial_health_score_model.dart';
import 'package:dhanq_app/services/financial_health_score_service.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('FinancialHealthScore JSON Loading Tests', () {
    test('should load FinancialHealthScoreModel from JSON', () async {
      // Load the JSON file
      final jsonString = await rootBundle.loadString('assets/financial_health_score.json');
      final jsonData = json.decode(jsonString);
      
      // Extract financial health score data
      final healthScoreData = jsonData['financialHealthScore'] as Map<String, dynamic>;
      
      // Create FinancialHealthScoreModel from JSON data
      final financialHealthScore = FinancialHealthScoreModel(
        score: healthScoreData['score'] as int,
        maxScore: healthScoreData['maxScore'] as int,
        status: healthScoreData['status'] as String,
        statusColor: Color(healthScoreData['statusColor']['value'] as int),
        description: healthScoreData['description'] as String,
      );
      
      // Verify the model was created correctly
      expect(financialHealthScore.score, equals(85));
      expect(financialHealthScore.maxScore, equals(100));
      expect(financialHealthScore.status, equals('Excellent'));
      expect(financialHealthScore.description, contains('excellent'));
      expect(financialHealthScore.scorePercentage, equals(85.0));
    });

    test('should load key metrics from JSON', () async {
      // Load the JSON file
      final jsonString = await rootBundle.loadString('assets/financial_health_score.json');
      final jsonData = json.decode(jsonString);
      
      // Extract key metrics data
      final keyMetricsData = jsonData['keyMetrics'] as List;
      
      // Create KeyMetricModel from JSON data
      final keyMetrics = keyMetricsData
          .map((metric) => KeyMetricModel(
                label: metric['label'] as String,
                value: metric['value'] as String,
                trend: metric['trend'] as String?,
                isPositiveTrend: metric['isPositiveTrend'] as bool,
                icon: IconData(metric['icon']['codePoint'] as int, fontFamily: metric['icon']['fontFamily'] as String),
                status: metric['status'] as String?,
              ))
          .toList();
      
      // Verify the models were created correctly
      expect(keyMetrics.length, equals(4));
      expect(keyMetrics[0].label, equals('Emergency Fund'));
      expect(keyMetrics[0].value, equals('₹15,200'));
      expect(keyMetrics[0].trend, equals('+12%'));
      expect(keyMetrics[0].isPositiveTrend, equals(true));
      expect(keyMetrics[0].status, equals('Well Funded'));
    });

    test('should load data through service', () async {
      final service = FinancialHealthScoreService();
      
      // Test loading financial health score
      final financialHealthScore = await service.getFinancialHealthScore();
      expect(financialHealthScore.score, equals(85));
      expect(financialHealthScore.maxScore, equals(100));
      expect(financialHealthScore.status, equals('Excellent'));
      
      // Test loading key metrics
      final keyMetrics = await service.getKeyMetrics();
      expect(keyMetrics.length, equals(4));
      expect(keyMetrics[0].label, equals('Emergency Fund'));
      
      // Test loading score breakdown
      final scoreBreakdown = await service.getScoreBreakdown();
      expect(scoreBreakdown.length, equals(5));
      expect(scoreBreakdown[0].category, equals('Savings & Emergency Fund'));
      
      // Test loading financial insights
      final financialInsights = await service.getFinancialInsights();
      expect(financialInsights.length, equals(6));
      expect(financialInsights[0].text, contains('emergency fund'));
      
      // Test loading monthly trend
      final monthlyTrend = await service.getMonthlyTrend();
      expect(monthlyTrend.data.length, equals(12));
      expect(monthlyTrend.labels.length, equals(12));
      expect(monthlyTrend.labels[0], equals('Jan'));
    });
  });
} 