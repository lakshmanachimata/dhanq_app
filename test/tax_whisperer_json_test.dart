import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:dhanq_app/models/tax_whisperer_model.dart';
import 'package:dhanq_app/services/tax_whisperer_service.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('TaxWhisperer JSON Loading Tests', () {
    test('should load TaxHealthScoreModel from JSON', () async {
      // Load the JSON file
      final jsonString = await rootBundle.loadString('assets/tax_whisperer.json');
      final jsonData = json.decode(jsonString);
      
      // Extract tax health score data
      final taxHealthScoreData = jsonData['taxHealthScore'] as Map<String, dynamic>;
      
      // Create TaxHealthScoreModel from JSON data
      final taxHealthScore = TaxHealthScoreModel(
        score: taxHealthScoreData['score'] as int,
        maxScore: taxHealthScoreData['maxScore'] as int,
        status: taxHealthScoreData['status'] as String,
        statusColor: Color(taxHealthScoreData['statusColor']['value'] as int),
        description: taxHealthScoreData['description'] as String,
        quickImprovements: (taxHealthScoreData['quickImprovements'] as List)
            .map((improvement) => QuickImprovementModel(
                  title: improvement['title'] as String,
                  isCompleted: improvement['isCompleted'] as bool,
                ))
            .toList(),
      );
      
      // Verify the model was created correctly
      expect(taxHealthScore.score, equals(78));
      expect(taxHealthScore.maxScore, equals(100));
      expect(taxHealthScore.status, equals('Good'));
      expect(taxHealthScore.description, contains('good shape'));
      expect(taxHealthScore.quickImprovements.length, equals(4));
      expect(taxHealthScore.quickImprovements[0].title, equals('Maximize retirement contributions'));
      expect(taxHealthScore.quickImprovements[0].isCompleted, equals(false));
    });

    test('should load data through service', () async {
      final service = TaxWhispererService();
      
      // Test loading tax health score
      final taxHealthScore = await service.getTaxHealthScore();
      expect(taxHealthScore.score, equals(78));
      expect(taxHealthScore.maxScore, equals(100));
      expect(taxHealthScore.status, equals('Good'));
      
      // Test loading tax liability forecast
      final forecast = await service.getTaxLiabilityForecast();
      expect(forecast.quarterlyTaxes.length, equals(4));
      expect(forecast.chartData.length, equals(8));
      
      // Test loading personalized deductions
      final deductions = await service.getPersonalizedDeductions();
      expect(deductions.length, equals(6));
      expect(deductions[0].title, equals('Home Office Deduction'));
    });
  });
} 