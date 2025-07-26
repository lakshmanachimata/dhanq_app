import 'package:flutter/material.dart';

import '../models/activity_model.dart';
import '../models/financial_service_model.dart';
import '../models/portfolio_model.dart';

enum LocationType { urban, rural }

class HomeService {
  // Get portfolio data
  Future<PortfolioModel> getPortfolioData() async {
    await Future.delayed(const Duration(milliseconds: 500));
    
    return PortfolioModel(
      totalValue: 1250000,
      todayGain: 12500,
      totalGain: 150000,
      gainPercentage: 13.6,
    );
  }

  // Get recent activities
  Future<List<ActivityModel>> getRecentActivities() async {
    await Future.delayed(const Duration(milliseconds: 300));
    
    return [
      ActivityModel(
        id: '1',
        title: 'Stock Investment',
        description: 'Purchased TechCorp shares',
        amount: 25000,
        timestamp: DateTime.now().subtract(const Duration(hours: 2)),
        type: ActivityType.investment,
      ),
      ActivityModel(
        id: '2',
        title: 'Mutual Fund Dividend',
        description: 'Dividend received from Large Cap Fund',
        amount: 1500,
        timestamp: DateTime.now().subtract(const Duration(days: 1)),
        type: ActivityType.dividend,
      ),
      ActivityModel(
        id: '3',
        title: 'Withdrawal',
        description: 'ATM withdrawal',
        amount: -5000,
        timestamp: DateTime.now().subtract(const Duration(days: 2)),
        type: ActivityType.withdrawal,
      ),
      ActivityModel(
        id: '4',
        title: 'Fund Transfer',
        description: 'Transferred to savings account',
        amount: -10000,
        timestamp: DateTime.now().subtract(const Duration(days: 3)),
        type: ActivityType.transfer,
      ),
    ];
  }

  // Get financial services based on location type
  Future<List<FinancialServiceModel>> getFinancialServices(LocationType locationType) async {
    await Future.delayed(const Duration(milliseconds: 200));
    
    if (locationType == LocationType.urban) {
      return [
        FinancialServiceModel(
          id: 'asset_management',
          name: 'Asset Management',
          description: 'Comprehensive asset tracking and management',
          icon: Icons.business,
          color: Colors.blue,
        ),
        FinancialServiceModel(
          id: 'smart_investor',
          name: 'Smart Investor Agent',
          description: 'AI-powered investment recommendations',
          icon: Icons.account_balance,
          color: Colors.green,
        ),
        FinancialServiceModel(
          id: 'debt_doctor',
          name: 'Debt-Doctor',
          description: 'Debt management and optimization',
          icon: Icons.medical_services,
          color: Colors.red,
        ),
        FinancialServiceModel(
          id: 'tax_whisperer',
          name: 'Tax Whisperer',
          description: 'Tax planning and optimization',
          icon: Icons.description,
          color: Colors.orange,
        ),
        FinancialServiceModel(
          id: 'financial_health',
          name: 'Financial Health Score',
          description: 'Track your financial wellness',
          icon: Icons.favorite,
          color: Colors.pink,
        ),
        FinancialServiceModel(
          id: 'fintech_integration',
          name: 'Integration with other FinTechs/APIs',
          description: 'Connect with other financial services',
          icon: Icons.api,
          color: Colors.purple,
        ),
      ];
    } else {
      return [
        FinancialServiceModel(
          id: 'kisaan_saathi',
          name: 'Kisaan Saathi',
          description: 'Agricultural financial assistance',
          icon: Icons.agriculture,
          color: Colors.green,
        ),
        FinancialServiceModel(
          id: 'farm_finance',
          name: 'Farm Finance Optimization',
          description: 'Optimize farm-related finances',
          icon: Icons.trending_up,
          color: Colors.blue,
        ),
        FinancialServiceModel(
          id: 'gov_schemes',
          name: 'Government Scheme Integration',
          description: 'Access government financial schemes',
          icon: Icons.account_balance,
          color: Colors.orange,
        ),
        FinancialServiceModel(
          id: 'weather_analysis',
          name: 'Weather & Market Impact Analysis',
          description: 'Analyze weather impact on markets',
          icon: Icons.cloud,
          color: Colors.cyan,
        ),
        FinancialServiceModel(
          id: 'vyapar_margdarshak',
          name: 'Vyapar Margdarshak',
          description: 'Business guidance and support',
          icon: Icons.store,
          color: Colors.purple,
        ),
        FinancialServiceModel(
          id: 'bachat_guru',
          name: 'Bachat Guru',
          description: 'Savings optimization expert',
          icon: Icons.savings,
          color: Colors.teal,
        ),
        FinancialServiceModel(
          id: 'voice_assistant',
          name: 'Voice-Assisted Transaction History & Expense Categorization',
          description: 'Voice-controlled financial tracking',
          icon: Icons.mic,
          color: Colors.indigo,
        ),
        FinancialServiceModel(
          id: 'financial_health_rural',
          name: 'Financial Health Score',
          description: 'Track your financial wellness',
          icon: Icons.favorite,
          color: Colors.pink,
        ),
        FinancialServiceModel(
          id: 'fintech_integration_rural',
          name: 'Integration with other FinTechs/APIs',
          description: 'Connect with other financial services',
          icon: Icons.api,
          color: Colors.brown,
        ),
      ];
    }
  }

  // Process voice query
  Future<String> processVoiceQuery(String query) async {
    await Future.delayed(const Duration(milliseconds: 1000));
    return 'I found information about $query. Here are the details...';
  }

  // Get portfolio breakdown
  Future<Map<String, double>> getPortfolioBreakdown() async {
    await Future.delayed(const Duration(milliseconds: 200));
    
    return {
      'Stocks': 40.0,
      'Mutual Funds': 30.0,
      'Fixed Deposits': 20.0,
      'Cash': 10.0,
    };
  }
}
