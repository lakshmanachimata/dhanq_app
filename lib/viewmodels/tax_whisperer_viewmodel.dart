import 'package:flutter/material.dart';
import '../models/tax_whisperer_model.dart';
import '../services/tax_whisperer_service.dart';

enum TaxWhispererViewState {
  initial,
  loading,
  loaded,
  error,
}

class TaxWhispererViewModel extends ChangeNotifier {
  final TaxWhispererService _service = TaxWhispererService();
  
  TaxWhispererViewState _state = TaxWhispererViewState.initial;
  String? _errorMessage;
  
  // Data models
  TaxHealthScoreModel? _taxHealthScore;
  TaxLiabilityForecastModel? _taxLiabilityForecast;
  List<PersonalizedDeductionModel> _personalizedDeductions = [];
  
  // Getters
  TaxWhispererViewState get state => _state;
  String? get errorMessage => _errorMessage;
  bool get isLoading => _state == TaxWhispererViewState.loading;
  
  TaxHealthScoreModel? get taxHealthScore => _taxHealthScore;
  TaxLiabilityForecastModel? get taxLiabilityForecast => _taxLiabilityForecast;
  List<PersonalizedDeductionModel> get personalizedDeductions => _personalizedDeductions;
  
  // Initialize data
  Future<void> initializeData() async {
    if (_state == TaxWhispererViewState.loading) return;
    
    _setState(TaxWhispererViewState.loading);
    
    try {
      // Load all data concurrently
      final results = await Future.wait([
        _service.getTaxHealthScore(),
        _service.getTaxLiabilityForecast(),
        _service.getPersonalizedDeductions(),
      ]);
      
      _taxHealthScore = results[0] as TaxHealthScoreModel;
      _taxLiabilityForecast = results[1] as TaxLiabilityForecastModel;
      _personalizedDeductions = results[2] as List<PersonalizedDeductionModel>;
      
      _setState(TaxWhispererViewState.loaded);
    } catch (e) {
      _errorMessage = 'Failed to load tax data: ${e.toString()}';
      _setState(TaxWhispererViewState.error);
    }
  }
  
  // Refresh data
  Future<void> refreshData() async {
    _taxHealthScore = null;
    _taxLiabilityForecast = null;
    _personalizedDeductions = [];
    await initializeData();
  }
  
  // Apply tax optimization
  Future<void> applyTaxOptimization() async {
    try {
      await _service.applyTaxOptimization();
      // You could show a success message or update the UI here
    } catch (e) {
      _errorMessage = 'Failed to apply tax optimization: ${e.toString()}';
      notifyListeners();
    }
  }
  
  // Learn more about deduction
  Future<void> learnMoreAboutDeduction(String deductionType) async {
    try {
      await _service.learnMoreAboutDeduction(deductionType);
      // You could show more details or navigate to a detail screen
    } catch (e) {
      _errorMessage = 'Failed to load deduction details: ${e.toString()}';
      notifyListeners();
    }
  }
  
  // Handle quick improvement tap
  void onQuickImprovementTap(QuickImprovementModel improvement) {
    // Handle tap on quick improvement
    print('Tapped on improvement: ${improvement.title}');
  }
  
  // Handle quarterly tax tap
  void onQuarterlyTaxTap(QuarterlyTaxModel tax) {
    // Handle tap on quarterly tax
    print('Tapped on ${tax.quarter}: ${tax.formattedAmount}');
  }
  
  // Handle deduction tap
  void onDeductionTap(PersonalizedDeductionModel deduction) {
    // Handle tap on deduction
    print('Tapped on ${deduction.title}: ${deduction.formattedValue}');
  }
  
  // Private methods
  void _setState(TaxWhispererViewState newState) {
    _state = newState;
    notifyListeners();
  }
} 