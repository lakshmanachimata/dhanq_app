import 'package:flutter/material.dart';
import '../models/kisaan_saathi_model.dart';
import '../services/kisaan_saathi_service.dart';

enum KisaanSaathiViewState {
  initial,
  loading,
  loaded,
  error,
}

class KisaanSaathiViewModel extends ChangeNotifier {
  final KisaanSaathiService _service = KisaanSaathiService();
  
  KisaanSaathiViewState _state = KisaanSaathiViewState.initial;
  String? _errorMessage;
  LanguageType _selectedLanguage = LanguageType.english;
  
  // Data models
  FarmFinanceModel? _farmFinanceData;
  List<GovernmentSchemeModel> _governmentSchemes = [];
  WeatherMarketModel? _weatherMarketData;
  MicroLoanSHGModel? _microLoanSHGData;
  VoiceQueryModel? _voiceQueryData;
  
  // Getters
  KisaanSaathiViewState get state => _state;
  String? get errorMessage => _errorMessage;
  bool get isLoading => _state == KisaanSaathiViewState.loading;
  
  LanguageType get selectedLanguage => _selectedLanguage;
  FarmFinanceModel? get farmFinanceData => _farmFinanceData;
  List<GovernmentSchemeModel> get governmentSchemes => _governmentSchemes;
  WeatherMarketModel? get weatherMarketData => _weatherMarketData;
  MicroLoanSHGModel? get microLoanSHGData => _microLoanSHGData;
  VoiceQueryModel? get voiceQueryData => _voiceQueryData;
  
  // Initialize data
  Future<void> initializeData() async {
    if (_state == KisaanSaathiViewState.loading) return;
    
    _setState(KisaanSaathiViewState.loading);
    
    try {
      // Load all data concurrently
      final results = await Future.wait([
        _service.getFarmFinanceData(),
        _service.getGovernmentSchemes(),
        _service.getWeatherMarketData(),
        _service.getMicroLoanSHGData(),
        _service.getVoiceQueryData(),
      ]);
      
      _farmFinanceData = results[0] as FarmFinanceModel;
      _governmentSchemes = results[1] as List<GovernmentSchemeModel>;
      _weatherMarketData = results[2] as WeatherMarketModel;
      _microLoanSHGData = results[3] as MicroLoanSHGModel;
      _voiceQueryData = results[4] as VoiceQueryModel;
      
      _setState(KisaanSaathiViewState.loaded);
    } catch (e) {
      _errorMessage = 'Failed to load Kisaan Saathi data: ${e.toString()}';
      _setState(KisaanSaathiViewState.error);
    }
  }
  
  // Refresh data
  Future<void> refreshData() async {
    _farmFinanceData = null;
    _governmentSchemes = [];
    _weatherMarketData = null;
    _microLoanSHGData = null;
    _voiceQueryData = null;
    await initializeData();
  }
  
  // Set language
  void setLanguage(LanguageType language) {
    _selectedLanguage = language;
    notifyListeners();
  }
  
  // Handle voice query
  Future<void> handleVoiceQuery(String query) async {
    try {
      await _service.processVoiceQuery(query);
      // Refresh data after voice query
      await refreshData();
    } catch (e) {
      _errorMessage = 'Failed to process voice query: ${e.toString()}';
      notifyListeners();
    }
  }
  
  // Start voice listening
  Future<void> startVoiceListening() async {
    try {
      await _service.startVoiceListening();
      // Update voice query data to show listening state
      if (_voiceQueryData != null) {
        _voiceQueryData = VoiceQueryModel(
          prompt: _voiceQueryData!.prompt,
          suggestedQuery: _voiceQueryData!.suggestedQuery,
          isListening: true,
        );
        notifyListeners();
      }
    } catch (e) {
      _errorMessage = 'Failed to start voice listening: ${e.toString()}';
      notifyListeners();
    }
  }
  
  // Stop voice listening
  Future<void> stopVoiceListening() async {
    try {
      await _service.stopVoiceListening();
      // Update voice query data to show not listening state
      if (_voiceQueryData != null) {
        _voiceQueryData = VoiceQueryModel(
          prompt: _voiceQueryData!.prompt,
          suggestedQuery: _voiceQueryData!.suggestedQuery,
          isListening: false,
        );
        notifyListeners();
      }
    } catch (e) {
      _errorMessage = 'Failed to stop voice listening: ${e.toString()}';
      notifyListeners();
    }
  }
  
  // Check scheme status
  Future<void> checkSchemeStatus(String schemeName) async {
    try {
      await _service.checkSchemeStatus(schemeName);
      // Refresh data after status check
      await refreshData();
    } catch (e) {
      _errorMessage = 'Failed to check scheme status: ${e.toString()}';
      notifyListeners();
    }
  }
  
  // View market prices
  Future<void> viewMarketPrices() async {
    try {
      await _service.viewMarketPrices();
      // Handle navigation or show detailed prices
    } catch (e) {
      _errorMessage = 'Failed to view market prices: ${e.toString()}';
      notifyListeners();
    }
  }
  
  // Repay loan
  Future<void> repayLoan(String loanId) async {
    try {
      await _service.repayLoan(loanId);
      // Refresh data after loan repayment
      await refreshData();
    } catch (e) {
      _errorMessage = 'Failed to process loan repayment: ${e.toString()}';
      notifyListeners();
    }
  }
  
  // Join SHG meeting
  Future<void> joinSHGMeeting(String meetingId) async {
    try {
      await _service.joinSHGMeeting(meetingId);
      // Handle meeting joining logic
    } catch (e) {
      _errorMessage = 'Failed to join SHG meeting: ${e.toString()}';
      notifyListeners();
    }
  }
  
  // Handle farm finance tap
  void onFarmFinanceTap() {
    print('Farm finance section tapped');
    // Navigate to detailed farm finance screen
  }
  
  // Handle government scheme tap
  void onGovernmentSchemeTap(GovernmentSchemeModel scheme) {
    print('Government scheme tapped: ${scheme.name}');
    // Handle scheme selection
  }
  
  // Handle weather market tap
  void onWeatherMarketTap() {
    print('Weather & market section tapped');
    // Navigate to detailed weather market screen
  }
  
  // Handle micro loan SHG tap
  void onMicroLoanSHGTap() {
    print('Micro loan & SHG section tapped');
    // Navigate to detailed micro loan SHG screen
  }
  
  // Handle suggested query tap
  void onSuggestedQueryTap() {
    if (_voiceQueryData != null) {
      handleVoiceQuery(_voiceQueryData!.suggestedQuery);
    }
  }
  
  // Private methods
  void _setState(KisaanSaathiViewState newState) {
    _state = newState;
    notifyListeners();
  }
} 