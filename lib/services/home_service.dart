import 'package:flutter/material.dart';

import '../models/activity_model.dart';
import '../models/financial_service_model.dart';
import '../models/portfolio_model.dart';
import '../viewmodels/home_viewmodel.dart';

class HomeService {
  // Simulate API call to get portfolio data
  Future<PortfolioModel> getPortfolioData() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return PortfolioModel(
      totalValue: 428750,
      monthlyChange: 4.2,
      investments: 285000,
      savings: 125000,
      expenses: 18750,
    );
  }

  // Simulate API call to get recent activities
  Future<List<ActivityModel>> getRecentActivities() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return [
      ActivityModel(
        id: '1',
        title: 'SIP Investment',
        amount: 5000,
        type: ActivityType.investment,
        date: DateTime.now(),
        icon: 'trending_up',
      ),
      ActivityModel(
        id: '2',
        title: 'Electricity Bill',
        amount: 1450,
        type: ActivityType.expense,
        date: DateTime.now().subtract(const Duration(days: 1)),
        icon: 'trending_down',
      ),
      ActivityModel(
        id: '3',
        title: 'Salary Credit',
        amount: 45000,
        type: ActivityType.income,
        date: DateTime.now().subtract(const Duration(days: 3)),
        icon: 'trending_up',
      ),
    ];
  }

  // Get financial services based on location
  List<FinancialServiceModel> getFinancialServices(LocationType locationType) {
    if (locationType == LocationType.urban) {
      return [
        FinancialServiceModel(
          id: 'asset_management',
          name: 'Asset Management',
          icon: Icons.business,
          color: Colors.blue,
          description: 'Comprehensive asset tracking and management',
        ),
        FinancialServiceModel(
          id: 'smart_investor',
          name: 'Smart Investor Agent',
          icon: Icons.account_balance,
          color: Colors.green,
          description: 'AI-powered investment recommendations',
        ),
        FinancialServiceModel(
          id: 'debt_doctor',
          name: 'Debt-Doctor',
          icon: Icons.medical_services,
          color: Colors.red,
          description: 'Debt management and optimization',
        ),
        FinancialServiceModel(
          id: 'tax_whisperer',
          name: 'Tax Whisperer',
          icon: Icons.description,
          color: Colors.orange,
          description: 'Tax planning and optimization',
        ),
        FinancialServiceModel(
          id: 'financial_health',
          name: 'Financial Health Score',
          icon: Icons.favorite,
          color: Colors.pink,
          description: 'Track your financial wellness',
        ),
        FinancialServiceModel(
          id: 'fintech_integration',
          name: 'FinTech Integration',
          icon: Icons.api,
          color: Colors.purple,
          description: 'Integration with other FinTechs/APIs',
        ),
      ];
    } else {
      // Rural services
      return [
        FinancialServiceModel(
          id: 'kisaan_saathi',
          name: 'Kisaan Saathi',
          icon: Icons.agriculture,
          color: Colors.green,
          description: 'Farmer assistance and support',
        ),
        FinancialServiceModel(
          id: 'farm_finance',
          name: 'Farm Finance Optimization',
          icon: Icons.trending_up,
          color: Colors.blue,
          description: 'Optimize farm financial planning',
        ),
        FinancialServiceModel(
          id: 'govt_schemes',
          name: 'Government Scheme Integration',
          icon: Icons.account_balance,
          color: Colors.orange,
          description: 'Access government schemes and subsidies',
        ),
        FinancialServiceModel(
          id: 'weather_market',
          name: 'Weather & Market Impact Analysis',
          icon: Icons.cloud,
          color: Colors.lightBlue,
          description: 'Weather and market impact on farming',
        ),
        FinancialServiceModel(
          id: 'vyapar_margdarshak',
          name: 'Vyapar Margdarshak',
          icon: Icons.store,
          color: Colors.purple,
          description: 'Business guidance and mentorship',
        ),
        FinancialServiceModel(
          id: 'bachat_guru',
          name: 'Bachat Guru',
          icon: Icons.savings,
          color: Colors.teal,
          description: 'Savings and investment guidance',
        ),
        FinancialServiceModel(
          id: 'voice_assisted',
          name: 'Voice-Assisted Transaction History',
          icon: Icons.mic,
          color: Colors.red,
          description: 'Voice-assisted expense categorization',
        ),
        FinancialServiceModel(
          id: 'financial_health',
          name: 'Financial Health Score',
          icon: Icons.favorite,
          color: Colors.pink,
          description: 'Track your financial wellness',
        ),
        FinancialServiceModel(
          id: 'fintech_integration',
          name: 'FinTech Integration',
          icon: Icons.api,
          color: Colors.indigo,
          description: 'Integration with other FinTechs/APIs',
        ),
      ];
    }
  }

  // Simulate voice search
  Future<String> processVoiceQuery(String query) async {
    await Future.delayed(const Duration(seconds: 1));
    if (query.toLowerCase().contains('savings')) {
      return 'Your monthly savings are ₹12,500';
    } else if (query.toLowerCase().contains('spend')) {
      return 'You spent ₹18,750 this month';
    } else {
      return 'I can help you with your finances. Try asking about your savings or expenses.';
    }
  }

  // Get portfolio breakdown
  Map<String, double> getPortfolioBreakdown() {
    return {'Investments': 285000, 'Savings': 125000, 'Expenses': 18750};
  }
}
