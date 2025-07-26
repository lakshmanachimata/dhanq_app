import 'package:flutter/material.dart';
import '../models/debt_doctor_model.dart';
import '../services/debt_doctor_service.dart';

enum DebtDoctorViewState {
  initial,
  loading,
  loaded,
  error,
}

class DebtDoctorViewModel extends ChangeNotifier {
  final DebtDoctorService _service = DebtDoctorService();
  
  DebtDoctorViewState _state = DebtDoctorViewState.initial;
  String? _errorMessage;
  
  // Data models
  DebtOverviewModel? _debtOverview;
  DebtBreakdownModel? _debtBreakdown;
  RepaymentStrategiesModel? _repaymentStrategies;
  CreditScoreModel? _creditScore;
  CreditScoreFactorsModel? _creditScoreFactors;
  
  // Getters
  DebtDoctorViewState get state => _state;
  String? get errorMessage => _errorMessage;
  bool get isLoading => _state == DebtDoctorViewState.loading;
  
  DebtOverviewModel? get debtOverview => _debtOverview;
  DebtBreakdownModel? get debtBreakdown => _debtBreakdown;
  RepaymentStrategiesModel? get repaymentStrategies => _repaymentStrategies;
  CreditScoreModel? get creditScore => _creditScore;
  CreditScoreFactorsModel? get creditScoreFactors => _creditScoreFactors;
  
  // Initialize data
  Future<void> initializeData() async {
    if (_state == DebtDoctorViewState.loading) return;
    
    _setState(DebtDoctorViewState.loading);
    
    try {
      // Load all data concurrently
      final results = await Future.wait([
        _service.getDebtOverview(),
        _service.getDebtBreakdown(),
        _service.getRepaymentStrategies(),
        _service.getCreditScore(),
        _service.getCreditScoreFactors(),
      ]);
      
      _debtOverview = results[0] as DebtOverviewModel;
      _debtBreakdown = results[1] as DebtBreakdownModel;
      _repaymentStrategies = results[2] as RepaymentStrategiesModel;
      _creditScore = results[3] as CreditScoreModel;
      _creditScoreFactors = results[4] as CreditScoreFactorsModel;
      
      _setState(DebtDoctorViewState.loaded);
    } catch (e) {
      _errorMessage = 'Failed to load debt data: ${e.toString()}';
      _setState(DebtDoctorViewState.error);
    }
  }
  
  // Refresh data
  Future<void> refreshData() async {
    _debtOverview = null;
    _debtBreakdown = null;
    _repaymentStrategies = null;
    _creditScore = null;
    _creditScoreFactors = null;
    await initializeData();
  }
  
  // Apply avalanche strategy
  Future<void> applyAvalancheStrategy() async {
    try {
      await _service.applyAvalancheStrategy();
      // You could show a success message or update the UI here
    } catch (e) {
      _errorMessage = 'Failed to apply strategy: ${e.toString()}';
      notifyListeners();
    }
  }
  
  // Handle debt breakdown item tap
  void onDebtBreakdownItemTap(DebtBreakdownItem item) {
    // Handle tap on debt breakdown item
    print('Tapped on ${item.type}: ${item.formattedAmount}');
  }
  
  // Handle repayment strategy tap
  void onRepaymentStrategyTap(RepaymentStrategyModel strategy) {
    // Handle tap on repayment strategy
    print('Tapped on ${strategy.name}');
  }
  
  // Handle credit score factor tap
  void onCreditScoreFactorTap(CreditScoreFactor factor) {
    // Handle tap on credit score factor
    print('Tapped on ${factor.name}: ${factor.status}');
  }
  
  // Private methods
  void _setState(DebtDoctorViewState newState) {
    _state = newState;
    notifyListeners();
  }
} 