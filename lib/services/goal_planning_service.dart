import 'package:flutter/material.dart';
import '../models/goal_planning_model.dart';

class GoalPlanningService {
  Future<GoalPlanningModel> getGoalPlanningData() async {
    await Future.delayed(const Duration(milliseconds: 800));

    return GoalPlanningModel(
      financialHealth: FinancialHealthSummary(
        status: 'Good',
        totalGoals: 5,
        monthlyContribution: 2850,
        completionPercentage: 70,
      ),
      goalsOverview: [
        GoalOverview(
          id: 'retirement',
          name: 'Retirement',
          icon: Icons.home,
          progress: 65,
          target: 1200000,
          color: const Color(0xFF8B4513),
        ),
        GoalOverview(
          id: 'education',
          name: 'Child\'s Education',
          icon: Icons.school,
          progress: 40,
          target: 85000,
          color: const Color(0xFF1E3A8A),
        ),
        GoalOverview(
          id: 'travel',
          name: 'Europe Trip',
          icon: Icons.flight,
          progress: 70,
          target: 15000,
          color: const Color(0xFF228B22),
        ),
      ],
      goalDetails: [
        GoalDetail(
          id: 'retirement',
          name: 'Retirement',
          currentSavings: 780000,
          monthlyContribution: 1500,
          targetDate: 2040,
          probabilityOfSuccess: 85,
          projectedGrowth: _generateRetirementProjection(),
        ),
        GoalDetail(
          id: 'education',
          name: 'Child\'s Education',
          currentSavings: 34000,
          monthlyContribution: 800,
          targetDate: 2030,
          probabilityOfSuccess: 75,
          projectedGrowth: _generateEducationProjection(),
        ),
        GoalDetail(
          id: 'travel',
          name: 'Europe Trip',
          currentSavings: 10500,
          monthlyContribution: 550,
          targetDate: 2025,
          probabilityOfSuccess: 90,
          projectedGrowth: _generateTravelProjection(),
        ),
      ],
      recommendations: [
        Recommendation(
          id: '1',
          description: 'Increase monthly contribution by ₹200 to improve success rate by 7%',
          improvementPercentage: 7,
        ),
        Recommendation(
          id: '2',
          description: 'Adjust retirement age by +2 years to improve success rate by 12%',
          improvementPercentage: 12,
        ),
      ],
    );
  }

  List<ProjectedGrowthPoint> _generateRetirementProjection() {
    return List.generate(18, (index) {
      final year = 2023 + index;
      final baseValue = 780000 + (index * 1500 * 12);
      return ProjectedGrowthPoint(
        year: year,
        conservative: baseValue * (1 + (0.04 * index)),
        expected: baseValue * (1 + (0.07 * index)),
        optimistic: baseValue * (1 + (0.10 * index)),
      );
    });
  }

  List<ProjectedGrowthPoint> _generateEducationProjection() {
    return List.generate(8, (index) {
      final year = 2023 + index;
      final baseValue = 34000 + (index * 800 * 12);
      return ProjectedGrowthPoint(
        year: year,
        conservative: baseValue * (1 + (0.03 * index)),
        expected: baseValue * (1 + (0.06 * index)),
        optimistic: baseValue * (1 + (0.09 * index)),
      );
    });
  }

  List<ProjectedGrowthPoint> _generateTravelProjection() {
    return List.generate(3, (index) {
      final year = 2023 + index;
      final baseValue = 10500 + (index * 550 * 12);
      return ProjectedGrowthPoint(
        year: year,
        conservative: baseValue * (1 + (0.02 * index)),
        expected: baseValue * (1 + (0.05 * index)),
        optimistic: baseValue * (1 + (0.08 * index)),
      );
    });
  }

  Future<void> applyRecommendation(String recommendationId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    // Simulate applying recommendation
  }
} 