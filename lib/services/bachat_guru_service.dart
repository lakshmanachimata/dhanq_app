import 'dart:async';
import '../models/bachat_guru_model.dart';
import 'package:flutter/material.dart';

class BachatGuruService {
  Future<void> _simulateDelay() async {
    await Future.delayed(const Duration(milliseconds: 800));
  }

  Future<SavingsSummaryModel> getSavingsSummary() async {
    await _simulateDelay();
    return SavingsSummaryModel(
      totalSavings: 4500.0,
      progress: 3,
      goal: 10,
      status: 'Growing steadily!',
      streakCount: 3,
    );
  }

  Future<List<SavingsTipModel>> getSavingsTips() async {
    await _simulateDelay();
    return [
      SavingsTipModel(
        title: 'Small Daily Savings',
        description: 'Save ₹20 from your daily tea budget',
        color: const Color(0xFFFFF9C4),
      ),
      SavingsTipModel(
        title: 'Weekly Saving Rule',
        description: 'Try the 50-30-20 rule for your farm income',
        color: const Color(0xFFFFEBEE),
      ),
    ];
  }

  Future<List<SavingsOptionModel>> getSavingsOptions() async {
    await _simulateDelay();
    return [
      SavingsOptionModel(
        name: 'Post Office Monthly Scheme',
        minAmount: '₹100',
        returns: '7.1%',
        period: '1-5 yrs',
        icon: Icons.mail,
        color: const Color(0xFFFFEBEE),
      ),
      SavingsOptionModel(
        name: 'Co-op Bank Recurring Deposit',
        minAmount: '₹50',
        returns: '6.5%',
        period: '6-36 mos',
        icon: Icons.account_balance,
        color: const Color(0xFFFFF3E0),
      ),
    ];
  }

  Future<List<CommunityChallengeModel>> getCommunityChallenges() async {
    await _simulateDelay();
    return [
      CommunityChallengeModel(
        title: 'Bicycle Challenge',
        description: 'Save enough for a new bicycle in 3 months',
        targetAmount: 8000.0,
        savedAmount: 3200.0,
        months: 3,
        icon: Icons.directions_bike,
        color: const Color(0xFFFFEBEE),
      ),
      CommunityChallengeModel(
        title: 'Education Fund',
        description: "Save for children's education fees",
        targetAmount: 12000.0,
        savedAmount: 4000.0,
        months: 6,
        icon: Icons.menu_book,
        color: const Color(0xFFFFF9C4),
      ),
      CommunityChallengeModel(
        title: 'Monsoon Emergency',
        description: 'Be prepared for the rainy season',
        targetAmount: 5000.0,
        savedAmount: 1000.0,
        months: 2,
        icon: Icons.umbrella,
        color: const Color(0xFFFFEBEE),
      ),
    ];
  }

  Future<List<AchievementModel>> getAchievements() async {
    await _simulateDelay();
    return [
      AchievementModel(
        title: 'First Saver',
        icon: Icons.emoji_events,
        color: const Color(0xFF8B4513),
      ),
      AchievementModel(
        title: 'Weekly Streak',
        icon: Icons.emoji_events,
        color: const Color(0xFFB5A642),
      ),
      AchievementModel(
        title: 'Goal Achiever',
        icon: Icons.emoji_events,
        color: const Color(0xFF8B4513),
      ),
    ];
  }
} 