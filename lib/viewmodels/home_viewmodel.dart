import 'package:flutter/material.dart';

import '../models/activity_model.dart';
import '../models/financial_service_model.dart';
import '../models/home_data_model.dart';
import '../models/portfolio_model.dart';
import '../services/home_service.dart';
import '../utils/permission_helper.dart';

enum HomeViewState { initial, loading, loaded, error }

class HomeViewModel extends ChangeNotifier {
  final HomeService _service = HomeService();

  HomeViewState _state = HomeViewState.initial;
  HomeDataModel? _homeData;
  String? _errorMessage;
  LocationType _locationType = LocationType.urban;
  String _searchQuery = '';
  bool _isListening = false;
  bool _onboardingCompleted = false;
  bool _isOnboardingLoading = false;

  // Getters
  HomeViewState get state => _state;
  HomeDataModel? get homeData => _homeData;
  String? get errorMessage => _errorMessage;
  bool get isLoading => _state == HomeViewState.loading;
  LocationType get locationType => _locationType;
  String get searchQuery => _searchQuery;
  bool get isListening => _isListening;
  bool get onboardingCompleted => _onboardingCompleted;
  bool get isOnboardingLoading => _isOnboardingLoading;

  // Legacy getters for backward compatibility
  PortfolioModel? get portfolioData => _homeData?.portfolio;
  List<ActivityModel> get recentActivities => _homeData?.activities ?? [];
  List<FinancialServiceModel> get financialServices {
    if (_homeData == null) return [];
    final key = _locationType == LocationType.urban ? 'urban' : 'rural';
    return _homeData!.financialServices[key] ?? [];
  }

  // Initialize data
  Future<void> initializeData() async {
    if (_state == HomeViewState.initial) {
      _state = HomeViewState.loading;
      notifyListeners();

      try {
        _homeData = await _service.getHomeData();
        _onboardingCompleted =
            _homeData?.userProfile.onboardingCompleted ?? false;
        _state = HomeViewState.loaded;
      } catch (e) {
        _errorMessage = e.toString();
        _state = HomeViewState.error;
      }

      notifyListeners();
    }
  }

  // Set location type
  void setLocationType(LocationType type) {
    _locationType = type;
    notifyListeners();
  }

  // Set search query
  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  // Start voice listening
  void startVoiceListening(BuildContext context) async {
    // TODO: Implement voice listening logic
    // get microphone permission
    //write code to get microphone permission
    final microphonePermission = await PermissionHelper.getMicrophonePermission(
      context,
    );
    // if permission is granted, start listening
    // if permission is not granted, show a dialog to the user to grant permission
    if (microphonePermission) {
      _isListening = true;
      notifyListeners();

      // Simulate voice processing
      Future.delayed(const Duration(seconds: 2), () {
        _isListening = false;
        notifyListeners();
      });
    }
  }

  // Handle service selection
  void onServiceSelected(FinancialServiceModel service) {
    // Handle service selection logic
  }

  // Handle activity selection
  void onActivitySelected(ActivityModel activity) {
    // Handle activity selection logic
  }

  // Handle portfolio details
  void onPortfolioDetails() {
    // Handle portfolio details navigation
  }

  // Handle see all activities
  void onSeeAllActivities() {
    // Handle see all activities navigation
  }

  // Clear search
  void clearSearch() {
    _searchQuery = '';
    notifyListeners();
  }

  // Complete onboarding
  void completeOnboarding() async {
    _isOnboardingLoading = true;
    _onboardingCompleted = true;
    notifyListeners();

    // Show 3-second loader
    await Future.delayed(const Duration(seconds: 3));

    // Refresh home page data
    await initializeData();

    _isOnboardingLoading = false;
    notifyListeners();
  }

  // Refresh data
  Future<void> refreshData() async {
    _state = HomeViewState.loading;
    notifyListeners();

    try {
      _homeData = await _service.getHomeData();
      _state = HomeViewState.loaded;
    } catch (e) {
      _errorMessage = e.toString();
      _state = HomeViewState.error;
    }

    notifyListeners();
  }
}
