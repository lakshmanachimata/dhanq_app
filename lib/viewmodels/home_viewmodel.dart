import 'package:flutter/material.dart';
import '../models/activity_model.dart';
import '../models/financial_service_model.dart';
import '../models/portfolio_model.dart';
import '../services/home_service.dart';

enum HomeViewState { initial, loading, success, error }

class HomeViewModel extends ChangeNotifier {
  final HomeService _homeService = HomeService();
  
  HomeViewState _state = HomeViewState.initial;
  LocationType _locationType = LocationType.urban;
  String _searchQuery = '';
  String _voiceResponse = '';
  
  PortfolioModel? _portfolioData;
  List<ActivityModel> _recentActivities = [];
  List<FinancialServiceModel> _financialServices = [];

  // Getters
  HomeViewState get state => _state;
  LocationType get locationType => _locationType;
  String get searchQuery => _searchQuery;
  String get voiceResponse => _voiceResponse;
  PortfolioModel? get portfolioData => _portfolioData;
  List<ActivityModel> get recentActivities => _recentActivities;
  List<FinancialServiceModel> get financialServices => _financialServices;
  bool get isLoading => _state == HomeViewState.loading;

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
    _portfolioData = await _homeService.getPortfolioData();
    notifyListeners();
  }

  // Load recent activities
  Future<void> _loadRecentActivities() async {
    _recentActivities = await _homeService.getRecentActivities();
    notifyListeners();
  }

  // Load financial services
  Future<void> _loadFinancialServices() async {
    _financialServices = await _homeService.getFinancialServices(_locationType);
    notifyListeners();
  }

  // Set location type
  void setLocationType(LocationType type) {
    _locationType = type;
    _loadFinancialServices(); // Reload services for new location
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
    
    _voiceResponse = await _homeService.processVoiceQuery(_searchQuery);
    notifyListeners();
  }

  // Start voice listening
  void startVoiceListening() {
    // Implement voice listening functionality
    print('Voice listening started');
  }

  // Stop voice listening
  void stopVoiceListening() {
    // Implement voice listening stop functionality
    print('Voice listening stopped');
  }

  // Handle service selection
  void onServiceSelected(FinancialServiceModel service) {
    print('Service selected: ${service.name}');
    // Handle service selection logic
  }

  // Handle activity selection
  void onActivitySelected(ActivityModel activity) {
    print('Activity selected: ${activity.title}');
    // Handle activity selection logic
  }

  // Handle portfolio details
  void onPortfolioDetails() {
    print('Portfolio details requested');
    // Navigate to portfolio details screen
  }

  // Handle see all activities
  void onSeeAllActivities() {
    print('See all activities requested');
    // Navigate to activities screen
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
} 