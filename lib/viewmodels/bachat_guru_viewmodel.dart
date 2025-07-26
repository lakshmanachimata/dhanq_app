import 'package:flutter/material.dart';

import '../models/bachat_guru_model.dart';
import '../services/bachat_guru_service.dart';

enum BachatGuruViewState { initial, loading, loaded, error }

class BachatGuruViewModel extends ChangeNotifier {
  final BachatGuruService _service = BachatGuruService();

  BachatGuruViewState _state = BachatGuruViewState.initial;
  String? _errorMessage;

  SavingsSummaryModel? _savingsSummary;
  List<SavingsTipModel> _savingsTips = [];
  List<SavingsOptionModel> _savingsOptions = [];
  List<CommunityChallengeModel> _communityChallenges = [];
  List<AchievementModel> _achievements = [];

  LanguageType _selectedLanguage = LanguageType.english;

  // Getters
  BachatGuruViewState get state => _state;
  String? get errorMessage => _errorMessage;
  bool get isLoading => _state == BachatGuruViewState.loading;

  SavingsSummaryModel? get savingsSummary => _savingsSummary;
  List<SavingsTipModel> get savingsTips => _savingsTips;
  List<SavingsOptionModel> get savingsOptions => _savingsOptions;
  List<CommunityChallengeModel> get communityChallenges => _communityChallenges;
  List<AchievementModel> get achievements => _achievements;
  LanguageType get selectedLanguage => _selectedLanguage;

  // Setters
  void setLanguage(LanguageType language) {
    if (_selectedLanguage != language) {
      _selectedLanguage = language;
      notifyListeners();
    }
  }

  // Initialize data
  Future<void> initializeData() async {
    if (_state == BachatGuruViewState.loading) return;
    _setState(BachatGuruViewState.loading);
    try {
      final results = await Future.wait([
        _service.getSavingsSummary(),
        _service.getSavingsTips(),
        _service.getSavingsOptions(),
        _service.getCommunityChallenges(),
        _service.getAchievements(),
      ]);
      _savingsSummary = results[0] as SavingsSummaryModel;
      _savingsTips = results[1] as List<SavingsTipModel>;
      _savingsOptions = results[2] as List<SavingsOptionModel>;
      _communityChallenges = results[3] as List<CommunityChallengeModel>;
      _achievements = results[4] as List<AchievementModel>;
      _setState(BachatGuruViewState.loaded);
    } catch (e) {
      _errorMessage = 'Failed to load Bachat Guru data: ${e.toString()}';
      _setState(BachatGuruViewState.error);
    }
  }

  // Refresh data
  Future<void> refreshData() async {
    _savingsSummary = null;
    _savingsTips = [];
    _savingsOptions = [];
    _communityChallenges = [];
    _achievements = [];
    await initializeData();
  }

  // Private methods
  void _setState(BachatGuruViewState newState) {
    _state = newState;
    notifyListeners();
  }
}
