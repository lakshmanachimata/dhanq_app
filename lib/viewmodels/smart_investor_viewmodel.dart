import 'package:flutter/material.dart';
import '../models/smart_investor_model.dart';
import '../services/smart_investor_service.dart';

enum SmartInvestorViewState { initial, loading, success, error }

class SmartInvestorViewModel extends ChangeNotifier {
  final SmartInvestorService _smartInvestorService = SmartInvestorService();
  
  SmartInvestorViewState _state = SmartInvestorViewState.initial;
  
  PortfolioAllocationModel? _portfolioAllocation;
  List<ActionableInsightModel> _actionableInsights = [];
  InterestRateImpactModel? _interestRateImpact;
  List<MarketSentimentModel> _marketSentimentAnalysis = [];

  // Getters
  SmartInvestorViewState get state => _state;
  PortfolioAllocationModel? get portfolioAllocation => _portfolioAllocation;
  List<ActionableInsightModel> get actionableInsights => _actionableInsights;
  InterestRateImpactModel? get interestRateImpact => _interestRateImpact;
  List<MarketSentimentModel> get marketSentimentAnalysis => _marketSentimentAnalysis;
  bool get isLoading => _state == SmartInvestorViewState.loading;

  // Initialize data
  Future<void> initializeData() async {
    _setState(SmartInvestorViewState.loading);
    
    try {
      await Future.wait([
        _loadPortfolioAllocation(),
        _loadActionableInsights(),
        _loadInterestRateImpact(),
        _loadMarketSentimentAnalysis(),
      ]);
      
      _setState(SmartInvestorViewState.success);
    } catch (e) {
      _setState(SmartInvestorViewState.error);
    }
  }

  // Load portfolio allocation
  Future<void> _loadPortfolioAllocation() async {
    _portfolioAllocation = await _smartInvestorService.getPortfolioAllocation();
    notifyListeners();
  }

  // Load actionable insights
  Future<void> _loadActionableInsights() async {
    _actionableInsights = await _smartInvestorService.getActionableInsights();
    notifyListeners();
  }

  // Load interest rate impact
  Future<void> _loadInterestRateImpact() async {
    _interestRateImpact = await _smartInvestorService.getInterestRateImpact();
    notifyListeners();
  }

  // Load market sentiment analysis
  Future<void> _loadMarketSentimentAnalysis() async {
    _marketSentimentAnalysis = await _smartInvestorService.getMarketSentimentAnalysis();
    notifyListeners();
  }

  // Handle actionable insight tap
  void onActionableInsightTap(ActionableInsightModel insight) {
    print('Actionable insight tapped: ${insight.title}');
    // Handle insight action
  }

  // Handle market sentiment tap
  void onMarketSentimentTap(MarketSentimentModel sentiment) {
    print('Market sentiment tapped: ${sentiment.title}');
    // Handle sentiment action
  }

  // Handle interest rate impact tap
  void onInterestRateImpactTap() {
    print('Interest rate impact tapped');
    // Handle interest rate impact action
  }

  // Refresh data
  Future<void> refreshData() async {
    await initializeData();
  }

  // Set state
  void _setState(SmartInvestorViewState state) {
    _state = state;
    notifyListeners();
  }
} 