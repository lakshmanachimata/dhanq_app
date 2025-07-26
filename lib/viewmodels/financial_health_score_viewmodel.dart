import 'package:flutter/material.dart';
import '../models/financial_health_score_model.dart';
import '../services/financial_health_score_service.dart';

enum FinancialHealthScoreViewState {
  initial,
  loading,
  loaded,
  error,
}

class FinancialHealthScoreViewModel extends ChangeNotifier {
  final FinancialHealthScoreService _service = FinancialHealthScoreService();
  
  FinancialHealthScoreViewState _state = FinancialHealthScoreViewState.initial;
  String? _errorMessage;
  
  // Data models
  FinancialHealthScoreModel? _financialHealthScore;
  List<KeyMetricModel> _keyMetrics = [];
  List<ScoreBreakdownModel> _scoreBreakdown = [];
  List<FinancialInsightModel> _financialInsights = [];
  MonthlyTrendModel? _monthlyTrend;
  LanguageType _selectedLanguage = LanguageType.english;
  
  // Getters
  FinancialHealthScoreViewState get state => _state;
  String? get errorMessage => _errorMessage;
  bool get isLoading => _state == FinancialHealthScoreViewState.loading;
  
  FinancialHealthScoreModel? get financialHealthScore => _financialHealthScore;
  List<KeyMetricModel> get keyMetrics => _keyMetrics;
  List<ScoreBreakdownModel> get scoreBreakdown => _scoreBreakdown;
  List<FinancialInsightModel> get financialInsights => _financialInsights;
  MonthlyTrendModel? get monthlyTrend => _monthlyTrend;
  LanguageType get selectedLanguage => _selectedLanguage;
  
  // Initialize data
  Future<void> initializeData() async {
    if (_state == FinancialHealthScoreViewState.loading) return;
    
    _setState(FinancialHealthScoreViewState.loading);
    
    try {
      // Load all data concurrently
      final results = await Future.wait([
        _service.getFinancialHealthScore(),
        _service.getKeyMetrics(),
        _service.getScoreBreakdown(),
        _service.getFinancialInsights(),
        _service.getMonthlyTrend(),
      ]);
      
      _financialHealthScore = results[0] as FinancialHealthScoreModel;
      _keyMetrics = results[1] as List<KeyMetricModel>;
      _scoreBreakdown = results[2] as List<ScoreBreakdownModel>;
      _financialInsights = results[3] as List<FinancialInsightModel>;
      _monthlyTrend = results[4] as MonthlyTrendModel;
      
      _setState(FinancialHealthScoreViewState.loaded);
    } catch (e) {
      _errorMessage = 'Failed to load financial health data: ${e.toString()}';
      _setState(FinancialHealthScoreViewState.error);
    }
  }
  
  // Refresh data
  Future<void> refreshData() async {
    _financialHealthScore = null;
    _keyMetrics = [];
    _scoreBreakdown = [];
    _financialInsights = [];
    _monthlyTrend = null;
    await initializeData();
  }
  
  // Apply financial optimization
  Future<void> applyFinancialOptimization() async {
    try {
      await _service.applyFinancialOptimization();
      // You could show a success message or update the UI here
    } catch (e) {
      _errorMessage = 'Failed to apply financial optimization: ${e.toString()}';
      notifyListeners();
    }
  }
  
  // Get detailed insight
  Future<void> getDetailedInsight(String insightType) async {
    try {
      await _service.getDetailedInsight(insightType);
      // You could show more details or navigate to a detail screen
    } catch (e) {
      _errorMessage = 'Failed to load detailed insight: ${e.toString()}';
      notifyListeners();
    }
  }
  
  // Language switching
  void setLanguage(LanguageType language) {
    _selectedLanguage = language;
    notifyListeners();
  }

  // Handle key metric tap
  void onKeyMetricTap(KeyMetricModel metric) {
    // Handle tap on key metric
    print('Tapped on metric: ${metric.label}');
  }
  
  // Handle score breakdown tap
  void onScoreBreakdownTap(ScoreBreakdownModel breakdown) {
    // Handle tap on score breakdown
    print('Tapped on breakdown: ${breakdown.category}');
  }
  
  // Handle financial insight tap
  void onFinancialInsightTap(FinancialInsightModel insight) {
    // Handle tap on financial insight
    print('Tapped on insight: ${insight.text}');
  }
  
  // Private methods
  void _setState(FinancialHealthScoreViewState newState) {
    _state = newState;
    notifyListeners();
  }
} 