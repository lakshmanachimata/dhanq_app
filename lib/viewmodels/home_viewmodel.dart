import 'package:flutter/material.dart';
import '../models/portfolio_model.dart';
import '../models/activity_model.dart';
import '../models/financial_service_model.dart';
import '../services/home_service.dart';

enum HomeViewState { initial, loading, success, error }
enum LocationType { urban, rural }

class HomeViewModel extends ChangeNotifier {
  final HomeService _homeService = HomeService();
  
  HomeViewState _state = HomeViewState.initial;
  LocationType _selectedLocation = LocationType.urban;
  String _searchQuery = '';
  String _voiceResponse = '';
  bool _isListening = false;
  
  PortfolioModel? _portfolio;
  List<ActivityModel> _recentActivities = [];
  List<FinancialServiceModel> _financialServices = [];

  // Getters
  HomeViewState get state => _state;
  LocationType get selectedLocation => _selectedLocation;
  String get searchQuery => _searchQuery;
  String get voiceResponse => _voiceResponse;
  bool get isLoading => _state == HomeViewState.loading;
  bool get isListening => _isListening;
  PortfolioModel? get portfolio => _portfolio;
  List<ActivityModel> get recentActivities => _recentActivities;
  List<FinancialServiceModel> get financialServices => _financialServices;

  // Initialize data
  Future<void> initializeData() async {
    _setState(HomeViewState.loading);
    try {
      await Future.wait([
        _loadPortfolioData(),
        _loadRecentActivities(),
        _loadFinancialServices(),
      ]);
      _setState(HomeViewState.success);
    } catch (e) {
      _setState(HomeViewState.error);
    }
  }

  // Load portfolio data
  Future<void> _loadPortfolioData() async {
    _portfolio = await _homeService.getPortfolioData();
    notifyListeners();
  }

  // Load recent activities
  Future<void> _loadRecentActivities() async {
    _recentActivities = await _homeService.getRecentActivities();
    notifyListeners();
  }

  // Load financial services
  Future<void> _loadFinancialServices() async {
    _financialServices = _homeService.getFinancialServices(_selectedLocation);
    notifyListeners();
  }

  // Set location type
  void setLocationType(LocationType locationType) {
    _selectedLocation = locationType;
    _loadFinancialServices();
    notifyListeners();
  }

  // Set search query
  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  // Handle voice search
  Future<void> handleVoiceSearch() async {
    if (_searchQuery.isEmpty) return;
    _isListening = true;
    notifyListeners();
    try {
      _voiceResponse = await _homeService.processVoiceQuery(_searchQuery);
      notifyListeners();
    } catch (e) {
      _voiceResponse = 'Sorry, I couldn\'t process your request.';
      notifyListeners();
    } finally {
      _isListening = false;
      notifyListeners();
    }
  }

  // Start voice listening
  void startVoiceListening() {
    _isListening = true;
    notifyListeners();
  }

  // Stop voice listening
  void stopVoiceListening() {
    _isListening = false;
    notifyListeners();
  }

  // Handle service selection
  void onServiceSelected(FinancialServiceModel service) {
    print('Selected service: ${service.name}');
  }

  // Handle activity selection
  void onActivitySelected(ActivityModel activity) {
    print('Selected activity: ${activity.title}');
  }

  // Handle portfolio details
  void onPortfolioDetails() {
    print('View portfolio details');
  }

  // Handle see all activities
  void onSeeAllActivities() {
    print('View all activities');
  }

  // Refresh data
  Future<void> refreshData() async {
    await initializeData();
  }

  // Set state
  void _setState(HomeViewState state) {
    _state = state;
    notifyListeners();
  }

  // Clear search
  void clearSearch() {
    _searchQuery = '';
    _voiceResponse = '';
    notifyListeners();
  }

  // Get formatted portfolio value
  String get formattedPortfolioValue {
    if (_portfolio == null) return '₹0';
    return _portfolio!.formattedTotalValue;
  }

  // Get formatted monthly change
  String get formattedMonthlyChange {
    if (_portfolio == null) return '+0.0% this month';
    return _portfolio!.formattedMonthlyChange;
  }

  // Get portfolio breakdown
  Map<String, String> get portfolioBreakdown {
    if (_portfolio == null) return {};
    return {
      'Investments': _portfolio!.formattedInvestments,
      'Savings': _portfolio!.formattedSavings,
      'Expenses': _portfolio!.formattedExpenses,
    };
  }

  // Check if portfolio has positive change
  bool get isPortfolioPositive {
    return _portfolio?.isPositiveChange ?? false;
  }
} 