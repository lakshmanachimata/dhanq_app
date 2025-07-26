import 'package:dhanq_app/models/voice_assist_model.dart';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart';

import '../models/activity_model.dart';
import '../models/financial_service_model.dart';
import '../models/home_data_model.dart';
import '../models/portfolio_model.dart';
import '../services/home_service.dart';
import '../services/voice_assist_service.dart';
import '../utils/permission_helper.dart';

enum HomeViewState { initial, loading, loaded, error }

class HomeViewModel extends ChangeNotifier {
  final HomeService _service = HomeService();
  final VoiceAssistService _voiceAssistService = VoiceAssistService();

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

  LanguageType _selectedLanguage = LanguageType.english;
  String _voiceInput = '';
  final TextEditingController searchController = TextEditingController();

  // Getters
  LanguageType get selectedLanguage => _selectedLanguage;
  String get voiceInput => _voiceInput;

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
    // Sync with search controller if it's different
    if (searchController.text != query) {
      searchController.text = query;
    }
    notifyListeners();
  }

  // Start voice listening
  Future<void> startVoiceListening(BuildContext context) async {
    final hasPermission = await PermissionHelper.getMicrophonePermission(
      context,
    );
    if (!hasPermission) return;

    _isListening = true;
    notifyListeners();
    // Start listening to audio and convert to text
    await _listenAndTranscribe(context);

    // Add your voice listening logic here
  }

  Future<void> _listenAndTranscribe(BuildContext context) async {
    try {
      final speech = SpeechToText();
      bool available = await speech.initialize(
        onStatus: (status) {
          if (status == 'notListening') {
            stopListening();
          }
        },
        onError: (error) {
          stopListening();
          debugPrint('Speech recognition error: $error');
        },
      );

      if (available) {
        await speech.listen(
          onResult: (result) {
            if (result.finalResult) {
              setVoiceInput(result.recognizedWords);
              stopListening();
            }
          },
          localeId: _selectedLanguage == LanguageType.hindi ? 'hi_IN' : 'en_US',
        );
      } else {
        debugPrint('Speech recognition not available');
        stopListening();
      }
    } catch (e) {
      debugPrint('Error during speech recognition: $e');
      stopListening();
    }
  }

  void stopListening() async {
    _isListening = false;
    notifyListeners();
  }

  Future<void> setVoiceInput(String input) async {
    _voiceInput = input;
    setSearchQuery(input); // Update search query with voice input
    searchController.text = input; // Set text in the search input box
    _isListening = false; // Stop listening after input is set
    notifyListeners();
    
    try {
      final mcpResp = await _voiceAssistService.processVoiceMessageFromMCP(input);
      if (mcpResp != null && mcpResp.isNotEmpty) {
        // Handle MCP response if needed
        debugPrint('MCP Response: $mcpResp');
        
        // If the response contains an error, you might want to show it to the user
        if (mcpResp.startsWith('Error:') || mcpResp.startsWith('Exception:')) {
          debugPrint('MCP Error: $mcpResp');
        }
      }
    } catch (e) {
      debugPrint('Error processing MCP request: $e');
    }
  }

  // Process voice input
  Future<void> processVoiceInput(String input) async {
    if (input.trim().isEmpty) return;

    // Add user message
    final userMessage = await _voiceAssistService.processVoiceInput(
      input,
      _selectedLanguage,
    );
    notifyListeners();

    // Generate response
    final response = await _voiceAssistService.generateResponse(
      userMessage,
      _selectedLanguage,
    );
    notifyListeners();

    // Clear input
    _voiceInput = '';
    notifyListeners();
  }

  // Get localized text
  String getLocalizedText(String englishText, String hindiText) {
    return _selectedLanguage == LanguageType.hindi ? hindiText : englishText;
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
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
