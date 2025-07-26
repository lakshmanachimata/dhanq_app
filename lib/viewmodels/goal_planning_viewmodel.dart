import 'package:flutter/material.dart';
import '../models/goal_planning_model.dart';
import '../services/goal_planning_service.dart';

enum GoalPlanningViewState { initial, loading, loaded, error }

class GoalPlanningViewModel extends ChangeNotifier {
  final GoalPlanningService _service = GoalPlanningService();

  GoalPlanningViewState _state = GoalPlanningViewState.initial;
  GoalPlanningModel? _data;
  String? _selectedGoalId;
  String? _errorMessage;

  // Getters
  GoalPlanningViewState get state => _state;
  GoalPlanningModel? get data => _data;
  String? get selectedGoalId => _selectedGoalId;
  String? get errorMessage => _errorMessage;
  bool get isLoading => _state == GoalPlanningViewState.loading;

  GoalDetail? get selectedGoalDetail {
    if (_data == null || _selectedGoalId == null) return null;
    return _data!.goalDetails.firstWhere(
      (goal) => goal.id == _selectedGoalId,
      orElse: () => _data!.goalDetails.first,
    );
  }

  // Initialize data
  Future<void> initializeData() async {
    if (_state == GoalPlanningViewState.initial) {
      _state = GoalPlanningViewState.loading;
      notifyListeners();

      try {
        _data = await _service.getGoalPlanningData();
        _selectedGoalId = _data!.goalDetails.first.id;
        _state = GoalPlanningViewState.loaded;
      } catch (e) {
        _errorMessage = e.toString();
        _state = GoalPlanningViewState.error;
      }

      notifyListeners();
    }
  }

  // Set selected goal
  void setSelectedGoal(String goalId) {
    _selectedGoalId = goalId;
    notifyListeners();
  }

  // Apply recommendation
  Future<void> applyRecommendation(String recommendationId) async {
    try {
      await _service.applyRecommendation(recommendationId);
      // Refresh data after applying recommendation
      await refreshData();
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  // Refresh data
  Future<void> refreshData() async {
    _state = GoalPlanningViewState.loading;
    notifyListeners();

    try {
      _data = await _service.getGoalPlanningData();
      _state = GoalPlanningViewState.loaded;
    } catch (e) {
      _errorMessage = e.toString();
      _state = GoalPlanningViewState.error;
    }

    notifyListeners();
  }
} 